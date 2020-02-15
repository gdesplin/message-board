class PostsController < ApplicationController

  before_action :user_signed_in?, except: :index

  def index
    @posts = Post.all.ordered
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(safe_params)
    if @post.save
      flash.notice = "Post created."
      redirect_to @post
    else
      flash.now.alert = "Error count: #{@post.errors.size}, see below."
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    authorize_user
    if @post.update(safe_params)
      flash.notice = "Post updated."
      redirect_to @post
    else
      flash.now.alert = "Error count: #{@post.errors.size}, see below."
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize_user
  end

  def destroy
    @post = Post.find(params[:id])
    authorize_user
    if @post.destroy
      flash.notice = "Post deleted."
      redirect_to :root
    else
      flash.now.alert = @post.errors.full_messages
      render :edit
    end
  end

  private

  def safe_params
    params.require(:post).permit(:body, :title)
  end

  def authorize_user
    return true if @post.user == current_user

    flash.alert = "You're unauthorized to do that."
    redirect_to :root && return
  end

end
