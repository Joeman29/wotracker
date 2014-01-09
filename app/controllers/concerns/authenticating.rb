module Authenticating
  extend ActiveSupport::Concern
  included do
    before_action :is_logged_in?, :except => [:login, :process_login, :logout]
  end

  def is_logged_in?
    unless controller_name == 'users' && %w[new create].include?(action_name)
      unless session[:user_id]
        flash[:notice] = 'Please log in'
        attempted_access_url = request.original_url
        redirect_to "/login", :redirect => attempted_access_url
        return false
      end
      if params[:user_id] && session[:user_id] != params[:user_id]
        return 'Access Denied'
      end
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
end