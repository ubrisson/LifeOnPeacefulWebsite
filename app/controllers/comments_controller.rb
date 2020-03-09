class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :admin_user, only: [:update, :destroy]

  def create
    session[:referrer] = request.referer if session[:referrer].nil?
    @comment = current_post.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'Comment successfully created.'
    else
      flash[:danger] = 'Failed to create new comment.'
    end
    helpers.redirect_back_or comments_path
  end

  def update
    session[:referrer] = request.referer if session[:referrer].nil?
    if @comment.update(comment_params)
      flash[:success] = 'Comment successfully updated.'
    else
      flash[:danger] = 'Failed to edit comment.'
    end
    helpers.redirect_back_or comments_path
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment successfully deleted."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:name, :body, :public)
  end

  def current_post
    @post = Post.find(params[:post_id])
  end
end
