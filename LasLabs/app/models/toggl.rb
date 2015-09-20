require "net/http"
require "json"
require "date"
require "base64"

class Toggl < ActiveRecord::Base
  after_initialize :init

  # CONSTANTS
  API_KEY = 'a0edfb029520fdf2f34ad3deba48261d'
  WORKSPACE_ID = 613053
  API_BASE = 'https://toggl.com'
  REPORT_URI = 'reports/api/v2'
  TOGGL_URI = 'api/v8'
  
  API_URLS = {
      detailed: 'details',
      weekly: 'weekly',
      summary: 'summary',
  }
  
  ##
  def init
    
    key = Base64.encode64("#{API_KEY}:api_token")
    
    api = URI.parse(API_BASE)
    @http = Net::HTTP.new(api.host, api.port)
    @http.use_ssl =  true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    @default_headers = {
      'User-Agent' => 'Dave Lasley - dave@dlasley.net - 702-508-8894',
      'From' => 'dave@dlasley.net',
      'Content-Type' => 'application/json',
      'Authorization' => "Basic #{key}"
    }
    
    @default_query = {
      user_agent: @default_headers['User-Agent'],
      workspace_id: WORKSPACE_ID
    }

  end
  
  ##  
  def get_pdf(cid, start_dt, end_dt)
        
    entry = TimeEntry.where(company_id: cid).order(:end).last #< @todo - cid
    if entry
      start_dt = entry['end'] + 1
    else
      start_dt = DateTime.new(2014,6,20)
    end
  
    end_dt = DateTime.now

    query = {
      since: start_dt.iso8601,
      until: end_dt.iso8601,
      client_ids: cid,
    }
    
    return _do_api_request REPORT_URI, 'details', query, true
    
  end
  
  ##
  def get(cid)
    
    entry = TimeEntry.where(company_id: cid).order(:end).last #< @todo - cid
    if entry
      start_dt = entry['end'] + 1.second
    else
      start_dt = DateTime.new(2014,6,24,0,0,0)
    end
  
    end_dt = DateTime.now
      
    require 'pp'
    pp entry
    puts start_dt
    
    query = {
      since: start_dt.iso8601,
      until: end_dt.iso8601,
      client_ids: cid,
      page: 1,
    }
    
    # Get report data, handle pagination
    data = { "total_seen" => 0, "total_count" => 1, "data" => [] }
    while data['total_count'] >= data['total_seen'] do
      data_ = _do_api_request REPORT_URI, 'details', query
      data = {
        'total_count' => data_['total_count'],
        'total_seen' => data['total_seen'] + data_['per_page'],
        'data' => data['data'] + data_['data'],
      }
      puts data['total_count']
      puts data['total_seen']
      query[:page] += 1
      puts "Report pagination loop"
      puts query[:page]
    end
    
    begin
      customer = data['data'][0]['client']
      project = get_project_details data['data'][0]['pid']
      #rate = project['data']['rate']
      
      project['cid'] = cid #<@todo -nasty
  
      return data, customer, project
    
    rescue
      return nil, nil, nil
    end
    
  end
  
  ##
  def insert_time_entries(records, rate, cid)
    
    inserts = []
    records.each do |rec|
      begin
        TimeEntry.create({
          start: rec['start'].to_time,
          end: rec['end'].to_time,
          rate: rate,
          description: rec['description'],
          tags: rec['tags'].join(','),
          company_id: cid,
          user_id: 1 #< @todo
        })
      rescue
        puts 'Write a better way to ignore pre-existing records'
      end
    end 
    
    TimeEntry.create(inserts)
    return inserts

  end
  
  ##
  def get_client_details(cid=nil)
    cid ||= nil
    _do_api_request TOGGL_URI, "clients/#{cid}"
  end
  
  ##
  def get_project_details(pid=nil)
    pid ||= nil
    _do_api_request TOGGL_URI, "projects/#{pid}"
  end
  
  private
    ##
    def _do_api_request(uri, type, query_data={}, pdf=false)
      
      uri = [API_BASE, uri, type].join('/')
      uri = URI.parse(uri)

      query_data.merge!(@default_query) {|key, v1, v2| v1} #< prefer original val
      uri.query = URI.encode_www_form(query_data)
      
      puts query_data
      
      req = Net::HTTP::Get.new(uri.request_uri, @default_headers)
  
      res = @http.request(req)
      if res.code == '200'
        if pdf
          return res.body
        else
          result = JSON.parse(res.body)
          return result
        end
      else
        raise "ERROR: #{res.code} - #{uri} - #{res}"
      end
      
      return nil
      
    end
  
end
