class RelationshipsController < ApplicationController
  def create
    relatinoship = Relationship.new(follower_id: session[:user_id], followed_id: params[:id])
    relatinoship.save
    redirect_to("/users/#{params[:id]}")
  end

  def destroy
    relatinoship = Relationship.find_by(follower_id: session[:user_id], followed_id: params[:id])
    relatinoship.destroy
    redirect_to("/users/#{params[:id]}")
  end

end
