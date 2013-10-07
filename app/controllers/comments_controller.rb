class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @topic = @post.topic
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
    #keep track of where people were
    session[:return_to] ||= request.referer

    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    @comment.user = @user
    authorize! :create, @post, message: "You need to be signed up to do that."
    if @comment.save
      flash[:notice] = "Comment was saved."
      #should bring people back to wherever they called new/create from
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @topic = @post.topic
    @user = current_user
    
    authorize! :edit, @comment, message: "You need to own the comment to edit it."
  end

  def update
    #keep track of where people were
    session[:return_to] ||= request.referer

    @comment = Comment.find(params[:id])
    @post = @comment.post
    @topic = @post.topic
    @user = current_user
    
    authorize! :update, @comment, message: "You need to own the comment to edit it."
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Comment was updated."
      #should bring people back to wherever they called edit/update from
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @topic = @post.topic
    @user = current_user
    id = @comment.id
    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    if @comment.destroy
      flash[:notice] = "Comment #\"#{id}\" was deleted successfully."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error deleting the comment."
      render :show
    end
  end
end