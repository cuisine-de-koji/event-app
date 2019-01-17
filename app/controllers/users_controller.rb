class UsersController < ApplicationController
  def new
	    @user = User.new
  end

  def create
    #@user = User.new(name: params[:name], email: params[:email], password: params[:password])
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to '/'
    else
      @errors = @user.errors.full_messages
      render 'new'

    end

  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password)

    end

end
