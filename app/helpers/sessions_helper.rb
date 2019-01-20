module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @errors = "ああああ#{session[:user_id]}"
  end

  def logged_in?
    @errors = session[:user_id]
    return !session[:user_id].nil?
  end
end
