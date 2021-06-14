class BooksController < ApplicationController
    layout "one_column", only: :edit
    before_action :authenticate_user!, only: [:edit,:show, :index]
    before_action :set_book, only: [:edit, :update, :destroy]
    before_action :set_new_book, only: [:index,:show]
    before_action :correct_user,only: [:edit, :update, :destroy]
    
    def index
        @books = Book.all
    end
    
    def show
        @book_record = Book.find(params[:id])
        @user = @book_record.user
    end
    
    def create
        @book = current_user.books.new(books_params)
        if @book.save
            redirect_to book_path(@book),notice: "You have created book successfully."
        else
            @books = Book.all
            render :index
        end
    end
    
    def edit
    end
    
    def update
        if @book.update(books_params)
            redirect_to book_path(@book), notice: "You have updated book successfully."
        else
            render :edit, :layout => "one_column"
        end
    end
    
    def destroy
        if @book.destroy
            redirect_to books_path, notice: "You have deleted book successfully."
        else
            redirect_to book_path(@book), notice: "You have not deleted book."
        end
    end
    
    private
    
     def set_book
         @book = Book.find(params[:id])
     end
     
     def set_new_book
         @book = Book.new
     end
     
     def books_params
         params.require(:book).permit(:title, :body)
     end
     
     def correct_user
         unless @book.user_id == current_user.id
             redirect_to books_path
         end
     end
    
end
