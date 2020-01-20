class BooksController < ApplicationController
    
before_action :authenticate_user!
before_action :ensure_correct_user, only: [:edit, :update, :destroy]

    def index
        @book = Book.new
        @books = Book.all.order("id desc")
        @new_book = Book.new
    end
    
    def show
        @book = Book.find(params[:id])
        @new_book = Book.new
        @user = User.find(@book.user_id)
    end
    
    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
            flash[:notice] = "Book was successfully created."
            redirect_to(book_path(@book))
        else
            @new_book = Book.new
            @books = Book.all.order("id desc")
            render(:index)
        end
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "Book was successfully Updated."
            redirect_to(book_path(@book.id))
        else
            render('books/edit')
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        flash[:notice] = "Book was successfully destroyed."
        redirect_to(books_path)
    end


    def ensure_correct_user
        @book = Book.find(params[:id])
        if @book.user_id != current_user.id
            redirect_to(books_path)
        end
    end

    private
        def book_params
            params.require(:book).permit(:title, :body)
        end
end
