class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:index, :show, :edit]
  before_action :set_user, only: [:show, :edit,:update]
  before_action :correct_user, only: [:edit,:update]
  layout "one_column", only: :edit
  
  def index
    @users = User.all
  end

  def show
    @books = current_user.books
  end

  def edit
  end
  
  def update
    if @user.update(users_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit, :layout => "one_column"
    end
  end
  
  private
  
    def set_book
      @book = Book.new
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def users_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
    
    def correct_user
      unless  @user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end
    
end
