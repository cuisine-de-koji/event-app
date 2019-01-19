class RelationshipsController < ApplicationController
  before_action :authenticate_user

  def create
    relatinoship = Relationship.new(follower_id: @current_user.id, followed_id: params[:id])
    relatinoship.save
    redirect_to("/users/#{params[:id]}")
  end

  def destroy
    relatinoship = Relationship.find_by(follower_id: @current_user.id, followed_id: params[:id])
    relatinoship.destroy
    redirect_to("/users/#{params[:id]}")
  end

end
