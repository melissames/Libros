class DiscussionsController < ApplicationController


  before_action :require_login, only: [:new, :create]
  before_action :get_discussion, only: [:show]

  def index
    @discussions = Discussion.all
    @discussion = Discussion.new
    @book = Book.new
  end

  def show
    @comment = Comment.new
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    if @discussion.save
      redirect_to @discussion
    else
      render :new
    end
  end

  def search
    @book = Book.make_book(params[:query]).first
    if !@book || @book == []
      flash[:notice] = "Please input a valid title!"
      redirect_to discussions_path
    else
      @discussion = Discussion.new(topic: params[:topic], book_id: @book.id)
      if @discussion.save
        redirect_to @discussion
      else
        flash[:notice] = "Please input a valid topic!"
        redirect_to discussions_path
      end
    end
  end

  private

  def get_discussion
    @discussion = Discussion.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:topic, :book_id)
  end

end
