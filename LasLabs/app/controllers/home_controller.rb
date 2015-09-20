class HomeController < ApplicationController
  before_action :only_admin
  def show
  end
  
  private
    def only_admin
      begin
        unless current_user.admin?
          flash[:error] = 'That URL was for admins only!'
          redirect_to request.env['HTTP_REFERER'] || invoices_url
        end
      rescue
    
      end
    end
end
