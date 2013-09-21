class FavoritesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    authorize! :create, Favorite, message: "You need to be a member to favorite posts."
    if current_user.favorites.create(post: @post)
      flash[:notice] = "Post favorited."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to add favorite. Please try again."
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @favorite = current_user.favorites.find(params[:id])

    authorize! :destroy, @favorite, message: "You need to be a member to unfavorite posts."
    if @favorite.destroy
      flash[:notice] = "Unfavorited post."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to remove favorite. Please try again."
      redirect_to [@topic, @post]
    end
  end
end
