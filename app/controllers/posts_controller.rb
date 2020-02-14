class PostsController < ApplicationController

  before_action :user_signed_in?, except: :index

  def index
    @posts = Post.all.order(created_at: :desc)
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
      redirect_to @post
    else
      render :new
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    authorize_user
    @post.update(safe_params)
  end

  def edit
    @post = current_user.posts.find(params[:id])
    authorize_user
  end

  def destroy
    @post = Post.find(params[:id])
    authorize_user
    @post.destroy
  end

  private

  def safe_params
    params.require(:post).permit(:body, :title)
  end

  def authorize_user
    return true if @post.user == current_user

    flash.alert= "You're unauthorized to do that."
    redirect_to :root
  end

end
