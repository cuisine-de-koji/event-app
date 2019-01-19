class UsersController < ApplicationController

  def index
	  @users = User.all
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
    ##dupメソッドにてコピーを作成（arrayクラスに変換すると、freeze=trueとなっており、pushメソッドが使用できない）
    @meetings = Meeting.where(userid: params[:id]).to_ary().dup()

    users_following = Relationship.where(follower_id: @current_user.id)
    users_followed = Relationship.where(followed_id: @current_user.id)

    users_following.each do |user|
	    relation = users_followed.find_by(follower_id: user.followed_id)
      if relation
        tmp = Meeting.where(userid: relation.follower_id).to_ary()
        #↑相互フォローユーザのMeeting取得時に、本人のMeetingを取得しないようにコントロールが必要

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

end
