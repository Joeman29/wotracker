class UsersController < ApplicationController
  include Authenticating
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    @editing = true
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:user][:password]
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_workouts_path(@user), notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
      redirect_to users_url
  end
  def login

  end
  def process_login
    @user = User.where(username: params[:username])
    if @user.empty?
      flash[:notice] = "No such username.  <a href='#{register_path}'>Create an account</a>"
      redirect_to action: 'login'
      return false
    end
    @user = @user.take
    if @user.authenticate?(params[:password])
      session[:user_id] = @user.id
      redirect_to user_workouts_path(@user)
    else
      flash[:notice] = 'Password does not match username.'
      redirect_to action: 'login'
    end

  end
  def logout
    session[:user_id] = nil
    redirect_to action: 'login'
  end
  def calendar

  end
  def log
    setDates
  end

  def historyCalendar
    setDates
    cw = CompletedWorkout.all
    cw = cw.where('date >= ?', params[:fromDate]) if @fromDate
    cw = cw.where('date <= ?', params[:toDate]) if @toDate
    @completed_workouts = cw
    render layout: false
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :password_confirmation, :email, :username, :city, :state, :country)
    end
    def setDates
      if params[:fromDate]
        vals = params[:fromDate].split('-').map {|s| s.to_i}
        @fromDate = Date.new(vals[0], vals[1], vals[2]) if vals.length == 3
      end
      if params[:toDate]
        vals = params[:toDate].split('-').map {|s| s.to_i}
        @toDate = Date.new(vals[0], vals[1], vals[2]) if vals.length == 3
      end
    end
end
