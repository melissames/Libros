class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy, :mark_as_read]
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :current_user, only: [:add_book, :book_suggestion]
  before_action :books_to_read, only: [:show]

  def home
  end

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
    @tags = Tag.all
  end

  def create
    @user = User.new(user_params(:name, :password, :password_confirmation, :bio))
    if params[:user][:tags]
       params[:user][:tags].each do |tag|
         @user.tags << Tag.find(tag)
       end
    end
    @user.image = params[:user][:picture].original_filename unless params[:user][:picture] == nil
    if @user.save
      upload unless params[:user][:picture] == nil
      session[:current_user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @tags = Tag.all
    if check_session
      render :edit
    else
      flash[:message] = "You can only edit your own profile"
      redirect_to user_path(@user)
    end
  end

  def update
    @user.assign_attributes(user_params(:name, :bio))
    @user.image = params[:user][:picture].original_filename unless params[:user][:picture] == nil
    if params[:user][:tags]
      params[:user][:tags].each do |tag|
        @user.tags << Tag.find(tag)
      end
    end
    if @user.save
      upload unless params[:user][:picture] == nil
      session[:current_user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def add_book
    @book = Book.find(params[:id])
    @current_user.add_to_reading_list(@book)
    redirect_to @current_user
  end

  def mark_as_read
    @user_book = @user.user_books.find(params[:user_book_id])
    @rating = params[:rating]
    @user.read_book(@user_book, @rating)

    redirect_to @user
  end

  def destroy
    if check_session
      session.clear
      @user.destroy
      redirect_to users_path
    else
      flash[:message] = "You can only delete your own account"
      redirect_to user_path(@user)
    end
  end

  def book_suggestion
    flash[:book_message] = "Here's a book I found specifically for you: "
    @book = @current_user.get_suggestion
    redirect_to book_path(@book)
  end

  def add_tag
    UserTag.find_or_create_by(user_id: session[:current_user_id], tag_id: params[:tag_id])
    flash[:tag] = "Successfully added tag to favorites"
    redirect_to books_path
  end

  private

    def upload
      uploaded_io = params[:user][:picture]
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end

    def user_params(*args)
      params.require(:user).permit(*args)
    end

    def get_user
      @user = User.find(params[:id])
    end

    def check_session
      params[:id].to_i == session[:current_user_id]
    end

    def current_user
      @current_user = User.find(session[:current_user_id])
    end

    def books_to_read
      @user = get_user
      @unread_books = []
      @read_books = []
      @user.user_books.select do |user_book|
        if user_book.read
          @read_books << user_book
        else
          @unread_books << user_book
        end
      end

    end

end
