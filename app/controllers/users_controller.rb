class UsersController < ApplicationController

  def index
    @users = User.all

    relationships_follower = Relationship.where(follower_id: @current_user.id).pluck(:followed_id)
    relationships_followed = Relationship.where(followed_id: @current_user.id).pluck(:follower_id)

    @follower = User.where(id: relationships_follower)
    @followed = User.where(id: relationships_followed)

  end

  def new
	  @user = User.new
  end

  def create
    #@user = User.new(name: params[:name], email: params[:email], password: params[:password])
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to '/'
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @meetings = Meeting.where(userid: params[:id]).to_ary().dup()

    if @user.id == @current_user.id

      relationships_each(@current_user.id).each do |relation|
        tmp = Meeting.where(userid: relation, hidden: false).to_ary

          tmp.each do |record|
            @meetings.push(record)
          end
      end

    end

  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password)

    end

    def relationships_each(userid)

      relationships_follower = Relationship.where(follower_id: userid).pluck(:followed_id)
      Relationship.where(followed_id: userid).where(follower_id: relationships_follower).pluck(:follower_id)

    end

end
