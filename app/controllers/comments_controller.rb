class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(safe_params.merge(user_id: current_user.id))
    if @comment.save(safe_params)
      flash.notice = "Comment updated."
    else
      flash.alert = @comment.errors.full_messages.join(", ")
    end
    redirect_to @comment.post
  end

  def update
    @comment = Comment.find(params[:id])
    return unless authorize_user

    if @comment.update(safe_params)
      flash.notice = "Comment updated."
    else
      flash.alert = @comment.errors.full_messages.join(", ")
    end
    redirect_to @comment.post
  end

  private

  def safe_params
    params.require(:comment).permit(:body, :post_id)
  end

  def authorize_user
    return true if @comment.user == current_user

    flash.alert = "You're unauthorized to do that."
    redirect_to :root and return
  end
end
