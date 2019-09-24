class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :cuser, only: [:update, :edit]

  def top
  end

  def about
  end

  def index
    @users = User.all
    @bookn = Book.new
    @user = User.find(current_user.id)
  end

  def posts
    @bookn = Book.new
    @books = Book.all
    @user = User.find(params[:id])
    @posts = @user.books
    render :show
  end

  def show
    @bookn = Book.new
    @books = Book.all
    @user = User.find(params[:id])
    @posts = @user.books

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to user_posts_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:introduction, :profile_image)
  end
    def cuser
      cuser = User.find(params[:id])
      if  cuser != current_user
      	redirect_to user_posts_path(current_user.id)
      end
    end
end