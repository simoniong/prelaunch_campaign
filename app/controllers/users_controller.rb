class UsersController < ApplicationController
  before_action :set_user, only: [ :create, :confirm, :refer ]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    #TODO
  end

  # GET /users/confirm
  def confirm
    #TODO
  end

  # GET /users/refer
  def refer
    #TODO
  end

  private

  def set_user
    @user = User.find_by_email( user_params[:email] )
  end

  def user_params
    params.require(:user).permit(:email)
  end

end
