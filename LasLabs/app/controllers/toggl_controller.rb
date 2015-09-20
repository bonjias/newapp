require "date"

class TogglController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :init

  def init
    @toggl = Toggl.new
  end

  # GET /toggl
  def get
    data, customer, project = @toggl.get(15230366)
    if data
      data = data['data'].reverse
      data = @toggl.insert_time_entries(data, project['data']['rate'], project['cid']) #< @todo- nasty
    end
    render json: data
  end

end
