class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :cbook, only: [:update, :destroy, :edit]

  def new
    @book = Book.new
  end

  def create
    @bookn = Book.new(book_params)
    @bookn.user_id = current_user.id
    @user = current_user
    @books = Book.all
    if @bookn.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@bookn)
    else
      render :index
    end
  end

  def index
    @books = Book.all
    @bookn = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @books = Book.all
    @bookn = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

    def cbook
      cbook = Book.find(params[:id])
      if  cbook.user != current_user
      	redirect_to books_path
      end
    end

end
