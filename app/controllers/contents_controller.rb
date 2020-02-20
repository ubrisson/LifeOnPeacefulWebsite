class ContentsController < ApplicationController
  def new
  end

  def posts
    @posts = Content.where(type: 'post').paginate(page: params[:page])
  end

  def quotes
    @quotes = Content.where(type: 'quote').paginate(page: params[:page])
  end
end
