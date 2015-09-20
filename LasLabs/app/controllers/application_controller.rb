class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :logger
  
  def logger
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  def current_user
    begin
      puts "Auth"
      @current_user ||= User.joins(:authorized_user).select(
        'users.*, authorized_users.company_id as company_id, authorized_users.admin as admin'
      ).find(session[:user_id]) if session[:user_id]
    rescue
      @current_user = nil
    end
  end

end

class InvalidUserError < StandardError
  attr_reader :obj
  def initialize(obj)
    @obj = obj
    flash[:error] = 'User not authorized for this service.'
    redirect_to :root
  end
end