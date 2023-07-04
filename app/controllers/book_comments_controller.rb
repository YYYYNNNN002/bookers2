class BookCommentsController < ApplicationController
  def create
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = params[:book_id]
    @book_comment.save
    redirect_to request.referer
  end

  def destroy
    @book_comment = BookComment.find_by(user_id: current_user.id, book_id: params[:book_id])
    if @book_comment.present? && user_is_comment_owner?
      @book_comment.destroy
    end
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def user_is_comment_owner?
    @book_comment.user_id == current_user.id
  end
end