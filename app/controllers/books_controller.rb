class BooksController < ApplicationController

  PER_PAGE = 10

  def index
    page = params[:more] ? params[:more].to_i : 0

    @books = Book.limit(PER_PAGE).offset PER_PAGE * page
    p @books
    @more  = page + 1 if @books.count == PER_PAGE
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find params[:id]
  end

  def show
    @book = Book.find params[:id]
  end

  def destroy
    @book = Book.find params[:id]
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find params[:id]

    if @book.update book_params
      flash[:success] = "Updated Book"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def create
    @book = Book.new book_params

    if @book.save
      flash[:success] = "Added Book"
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :published_on, :description, :image)
  end

end