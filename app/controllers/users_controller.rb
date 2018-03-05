class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy]

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
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params(:name))
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

    def user_params(*args)
      params.require(:user).permit(*args)
    end

    def get_user
      @user = User.find(params[:id])
    end

end
