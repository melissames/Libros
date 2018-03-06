class DiscussionsController < ApplicationController


  before_action :require_login, only: [:new, :create]
  before_action :get_discussion, only: [:show]

  def index
    @discussions = Discussion.all
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

  private

  def get_discussion
    @discussion = Discussion.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:topic, :book_id)
  end

end
