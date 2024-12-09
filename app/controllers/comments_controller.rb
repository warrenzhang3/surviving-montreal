# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @article, notice: 'Comment was successfully created.' }
        format.turbo_stream
      end
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end
end
