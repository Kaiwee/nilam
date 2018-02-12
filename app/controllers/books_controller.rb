class BooksController < ApplicationController

	before_action :find_book, only: [:show, :edit, :update]
	before_action :check_current_book, only: [:edit, :update]

	def index
		@books = current_user.books.all.order("created_at DESC")
	end

	def show
	end

	def new
		@book = Book.new
	end

	def edit
	end

	def create
		@book = current_user.books.new(book_params)
		if @book.save
			redirect_to @book
		else
			render "new"
		end
	end

	def update
		@book.update(book_params)
		redirect_to @book
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		respond_to do |format|
			format.html { redirect_to books_path }
			format.js
		end
	end

	private

	def find_book
		if @book = Book.find_by(id: params[:id])
			return @book
		else
			redirect_to '/', notice: "book does not exist"
		end	
	end

	def check_current_book
		@user = User.find_by(id: @book.user_id)
		if logged_in? and current_user.id != @user.id
			redirect_to "/", notice: "This is not your book"
		elsif !logged_in?
			redirect_to "/", notice: "You need to log in first"
		end
	end

	def book_params
		params.require(:book).permit(:title, :author, :type, :pages, :description, :comment)
	end

end
