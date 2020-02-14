class CommentsController < ApplicationController

  before_action :user_signed_in?

  def create
    @comment = Comment.create(safe_params.merge(user_id: current_user.id))
    redirect_to @comment.post
  end

  def update
    @comment = current_user.comments.find(params[:id])
    authorize_user
    @comment.update(safe_params)
  end

  def edit
    @comment = current_user.comments.find(params[:id])
    authorize_user
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    authorize_user
    @comment.destroy
  end

  private

  def safe_params
    params.require(:comment).permit(:body, :post_id)
  end

  def authorize_user
    return true if @comment.user == current_user

    flash.alert= "You're unauthorized to do that."
    redirect_to :root
  end

end
