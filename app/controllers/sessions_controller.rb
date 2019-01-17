class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase, password: params[:session][:password])
    if @user
      # 変数sessionに、ログインに成功したユーザーのidを代入してください
      #session[:user_id] = @user.id
      log_in(@user)
      flash[:notice] = "ログインしました"
      redirect_to("/")
    else
      @errors = "メールアドレスまたはパスワードが間違っています"
      @email = params[:session][:email]
      @password = params[:session][:password]
      render("sessions/new")
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to '/'
  end
end
