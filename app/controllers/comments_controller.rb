class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @user = current_user
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = current_user
    authorize! :create, Comment, message: "You need to be a member to create a new comment."
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    @comment.user = @user
    authorize! :create, @post, message: "You need to be signed up to do that."
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post, @comment]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.find(params[:id])
    authorize! :edit, @comment, message: "You need to own the comment to edit it."
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.find(params[:id])
    authorize! :update, @comment, message: "You need to own the comment to edit it."
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Comment was updated."
      redirect_to [@topic, @post, @comment]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :edit
    end
  end
end