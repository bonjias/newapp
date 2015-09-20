class AuthorizedUsersController < ApplicationController
  before_action :only_admin
  before_action :set_authorized_user, only: [:show, :edit, :update, :destroy]

  # GET /authorized_users
  # GET /authorized_users.json
  def index
    @authorized_users = AuthorizedUser.all
  end

  # GET /authorized_users/1
  # GET /authorized_users/1.json
  def show
  end

  # GET /authorized_users/new
  def new
    @authorized_user = AuthorizedUser.new
  end

  # GET /authorized_users/1/edit
  def edit
  end

  # POST /authorized_users
  # POST /authorized_users.json
  def create
    @authorized_user = AuthorizedUser.new(authorized_user_params)

    respond_to do |format|
      if @authorized_user.save
        format.html { redirect_to @authorized_user, notice: 'Authorized user was successfully created.' }
        format.json { render :show, status: :created, location: @authorized_user }
      else
        format.html { render :new }
        format.json { render json: @authorized_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authorized_users/1
  # PATCH/PUT /authorized_users/1.json
  def update
    respond_to do |format|
      if @authorized_user.update(authorized_user_params)
        format.html { redirect_to @authorized_user, notice: 'Authorized user was successfully updated.' }
        format.json { render :show, status: :ok, location: @authorized_user }
      else
        format.html { render :edit }
        format.json { render json: @authorized_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authorized_users/1
  # DELETE /authorized_users/1.json
  def destroy
    @authorized_user.destroy
    respond_to do |format|
      format.html { redirect_to authorized_users_url, notice: 'Authorized user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authorized_user
      @authorized_user = AuthorizedUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authorized_user_params
      params.require(:authorized_user).permit(:email, :company)
    end
    
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
