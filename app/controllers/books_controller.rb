class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book_comments = BookComment.where(book_id: params[:id])
    if ViewCount.find_by(user_id: current_user.id, book_id: @book.id).nil?
      current_user.view_counts.create(book_id: @book.id)
    end
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless user_is_book_owner?
       redirect_to book_path(@book), alert: "You are not authorized to edit information in this book."
    end
  end

  def update
    @book = Book.find(params[:id])
    if user_is_book_owner?
      if @book.update(book_params)
        redirect_to book_path(@book), notice: "You have updated book successfully."
      else
        render "edit"
      end
    else
      redirect_to book_path(@book), alert: "You are not authorized to edit information in this book."
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to user_path(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def user_is_book_owner?
    @book.user_id == current_user.id
  end
end
