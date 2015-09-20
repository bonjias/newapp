require "quickbooks-ruby"
require "oauth"
require "roxml"
require "nokogiri"
require "active_model"

class QboController < ApplicationController
  
  COMPANY_ID = 370358736
  
  before_action :only_admin
  before_action :init
  
  def init
    @qbo = Qbo.new(current_user)
  end
  
  def authenticate
    callback = qbo_oauth_callback_url
    token = $qb_oauth_consumer.get_request_token(oauth_callback: callback)
    session[:qb_request_token] = Marshal.dump(token)
    redirect_to("https://appcenter.intuit.com/Connect/Begin?oauth_token=#{token.token}") and return
  end

  def oauth_callback
    at = Marshal.load(session[:qb_request_token]).get_access_token(oauth_verifier: params[:oauth_verifier])
    tok = at.token
    sec = at.secret
    realm = params['realmId']
    puts current_user.inspect
    @qbo.update_qbo sec, tok, realm
    flash[:success] = "QuickBooks linked successfully."
    redirect_to root_url
  end
  
  def get_items
    service = _new_service(Quickbooks::Service::Item.new)
    items = {}
    service.query("SELECT * FROM Item").entries.each do |item|
      items[item.fully_qualified_name] = item
    end
    return items
  end
  
  def get_client(id)
    service = _new_service(Quickbooks::Service::Customer.new)
    return service.fetch_by_id(id)
  end
    
  # Get /qbo/new_invoice
  def new_invoice
    
    item_types = get_items
    company = Company.find(current_user.company_id)
    qbo_client = get_client(company.qb_client_id)

    time_entries = TimeEntry.where(invoice_id: nil).where(company_id: company.toggl_id).order(:start)
    
    ##  @todo rid the dup logic with a QBO api call backwards
    last = Invoice.where(company_id: company.id).order(:end).last
    if last
      invoice_start = last.end + 1
    else
      invoice_start = company.created_at
    end

    fees = 0.0
    time_entries.each do |entry|
      hours = (entry.end - entry.start) / 3600
      fees += hours * entry.rate
    end
    
    invoice_end = time_entries.last
    if invoice_end
      invoice_end = invoice_end.end
    else
      invoice_end = DateTime.now
    end

    invoice_date = DateTime.now
    invoice_name = "#{company.shortname.upcase}-#{invoice_date.strftime('%m%d%y')}"
    
    # Dup check @todo- better, and higher
    if Invoice.where(qb_name: invoice_name).length > 0
      flash[:error] = 'Cannot generate two invoices in the same day.'
      redirect_to invoices_url
      return
    end
    
    # DB
    invoice = {
      start: invoice_start,
      end: invoice_end,
      total: fees,
      company_id: company.id,
      qb_name: invoice_name,
      created_at: invoice_date,
    }
    invoice = Invoice.create(invoice)
    
    # QBO
    item_types = get_items

    qbo_invoice = Quickbooks::Model::Invoice.new({
      customer_id: company.qb_client_id,
      txn_date: invoice_date,
      doc_number: invoice_name,
      bill_email: qbo_client.primary_email_address,
      email_status: 'NeedToSend',
      sales_term_id: qbo_client.sales_term_ref,
      customer_memo: qbo_client.notes,
    })
    
    time_entries.each do |entry|

      entry.update(invoice_id: invoice.id)
      
      hours = (entry.end - entry.start) / 3600
      times = "[#{entry.start.strftime('%H:%M:%S')}-#{entry.end.strftime('%H:%M:%S')}]"
      
      line_item = Quickbooks::Model::InvoiceLineItem.new({
        amount: hours * entry.rate,
        description: "#{times} - #{entry.description}",
      })

      line_item.sales_item! do |detail|
        
        detail.unit_price = entry.rate
        detail.quantity = hours
        detail.service_date = entry.start
        
        begin
          
          tag_type, tag_name = entry.tags.split(',')[0].split(' - ')
          tag = "#{tag_type}:#{tag_name}"
  
          if item_types[tag]
            detail.item_id = item_types[tag].id
          else
            detail.item_id = item_types["Hours"].id
          end
          
        rescue
          detail.item_id = item_types["Hours"].id
        end
        
      end
      
      qbo_invoice.line_items << line_item
      
    end

    service = _new_service(Quickbooks::Service::Invoice.new)
    begin
      new_invoice = service.create(qbo_invoice)
      flash[:success] = "Invoice ID #{new_invoice.id} (#{new_invoice.doc_number}) Generated Successfully!"
    rescue
      puts "@todo - Fix the double refresh"
    end
    
    redirect_to invoices_url
    
  end
  
  private
  def _new_service(service)
    service = service
    service.company_id = COMPANY_ID
    service.access_token = @qbo.token
    return service
  end
  
  def only_admin
    begin
      unless current_user.admin?
        flash[:error] = 'That URL was for admins only!'
        redirect_to time_entries_url
      end
    rescue
    
    end
  end
  
end
