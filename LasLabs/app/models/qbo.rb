require "time"
require "quickbooks-ruby"
require "oauth"
require "roxml"
require "nokogiri"
require "active_model"

class Qbo
  
  attr_accessor :token
  
  def initialize(user)
    @user = user
    if user.enc_qbo_secret
      new_token
    end
  end
  
  def update_qbo(sec, tok, company_id)
    @user.enc_qbo_secret = sec
    @user.enc_qbo_token = tok
    @user.enc_qbo_company_id = company_id
    @user.qbo_token_exp = 6.months.from_now.utc
    @user.qbo_reconnect_tok = 5.months.from_now.utc
    @user.save!
  end
  
  def new_token
    @token = OAuth::AccessToken.new($qb_oauth_consumer, @user.enc_qbo_token, @user.enc_qbo_secret)
  end
  
  def update_expiring
    self.where(["qbo_reconnect_token < ?", time.now()]) do |row|
      token = OAuth::AccessToken.new($qb_oauth_consumer, row.enc_qbo_token, row.enc_qbo_secret)
      service = Quickbooks::Service::AccessToken.new
      service.access_token = token
      service.company_id = row.enc_qbo_company_id
      result = service.renew
      
      update_qbo(row, result.secret, result.token, service.company_id)
      
    end
  end
  
end
