class TagsController < ApplicationController

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.find_or_create_by(tag_params(:name))
    if @tag
      @book_tag = BookTag.create(tag_id: @tag.id, book_id: book_params)
      book_redirect
    end
  end

  private

  def tag_params(*args)
    params.require(:tag).permit(*args)
  end

  def book_params
    params[:tag][:book_id]
  end

  def book_redirect
    redirect_to book_path(book_params)
  end
end
