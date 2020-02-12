class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(safe_params)
  end

  def update
    @post = current_user.find(params[:id])
    @post.update(safe_params)
  end

  def edit
    @post = current_user.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  private

  def safe_params
    params.require(:post).permit(:body, :title)
  end

end
