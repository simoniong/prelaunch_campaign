class UsersController < ApplicationController
  before_action :set_user, only: [ :create, :confirm, :show ]
  before_action :filter_the_same_ip, only: [ :create ]
  before_action :filter_user_exists, only: [ :create ]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new( user_params )
    if @user.save
      cookies[:h_email] = { :value => @user.email }
      redirect_to @user
    else
      redirect_to root_path, "Something went wrong!"
    end
  end

  # GET /users/confirm
  def confirm
  end

  # GET /users/:id
  def show
  end

  private

  def set_user
    @user = User.find_by_email( user_params[:email] )
  end

  def user_params
    params.require(:user).permit(:email)
  end

  def filter_the_same_ip
    unless @user
      current_ip = IpAddress.find_or_create_by( address: request.remote_ip )
      current_ip.increment!(:count)

      if current_ip.count > 1
        redirect_to root_path, notice: 'You are trying to subscribe different email in the same place, right?'
      end
    end
  end

  def filter_user_exists
    redirect_to @user if @user
  end

end
