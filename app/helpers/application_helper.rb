module ApplicationHelper

  def current_user
    @current_user ||= session[:user_id] ? User.find(session[:user_id]) : nil
  end
  def time_to_string(seconds)
    minutesStr = "0#{(seconds/60).to_i}"[-2..-1]
    secondsStr = "0#{(seconds % 60).to_i}"[-2..-1]
    "#{minutesStr}:#{secondsStr}"
  end
end
