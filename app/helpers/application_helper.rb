module ApplicationHelper

  def current_user
    @current_user ||= Customer.find(session[:user_id]) if session[:user_id]
  end
  def Logged_in?
    !!current_user
  end
end
