class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @comments = @post.comments.paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
    authorize! :create, Post, message: "You need to be a member to create a new post."
  end

  # Adding a create method to the posts_controller.rb

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(params[:post])
    @post.topic = @topic
    authorize! :create, @post, message: "You need to be signed up to do that."
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own the post to edit it."
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :update, @post, message: "You need to own the post to edit it."
    if @post.update_attributes(params[:post])
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end
end
