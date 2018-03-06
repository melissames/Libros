class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]


  def home

  end

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params(:name, :password, :password_confirmation))
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    if check_session
      render :edit
    else
      flash[:message] = "You can only edit your own profile"
      redirect_to user_path(@user)
    end
  end

  def update
    if @user.update(user_params(:name))
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if check_session
      @user.destroy
      redirect_to users_path
    else
      flash[:message] = "You can only delete your own account"
      redirect_to user_path(@user)
    end
  end

  private

    def user_params(*args)
      params.require(:user).permit(*args)
    end

    def get_user
      @user = User.find(params[:id])
    end

    def check_session
      params[:id] == session[:current_user_id]
    end


end
