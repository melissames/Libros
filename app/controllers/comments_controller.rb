class CommentsController < ApplicationController
  before_action :get_comment, only: [:show]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to discussion_path(@comment.discussion_id)
    else
      render :new
    end
  end

  private
  def get_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:discussion_id, :content, :user_id)
  end

end
