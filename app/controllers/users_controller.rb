class UsersController < ApplicationController
  include Authenticating
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new(country:'United States')
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
    @user.password = params[:user][:password]
    if @user.update(user_params)
      redirect_to edit_user_path, notice: 'Profile was successfully updated.'
    else
      redirect_to edit_user_path, notice: 'Could not update profile.'
    end
  end

  def destroy
    @user.destroy
      redirect_to users_url
  end
  def calendar

  end
  def log
    setDates
  end

  def historyCalendar
    setDates
    cw = current_user.completed_workouts
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
