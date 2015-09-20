require "digest/md5"
class TimeEntry < ActiveRecord::Base
  
  has_one :invoices, primary_key: 'invoice_id', foreign_key: 'id'
  has_one :authorized_user, primary_key: 'user_id', foreign_key: 'id'
  has_one :company, primary_key: 'company_id', foreign_key: 'toggl_id'
  accepts_nested_attributes_for :company
  before_create :uid

  def self.get_by_invoice(id)
    return TimeEntry.joins(:company).where(invoice_id: id).select('time_entries.*, companies.*')
  end
  
  private
    def uid
      self.signature = Digest::MD5.hexdigest(
        "#{self.start}#{self.end}#{self.company_id}#{self.user_id}"
      )
    end
end
