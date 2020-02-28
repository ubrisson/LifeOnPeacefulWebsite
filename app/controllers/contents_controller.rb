class ContentsController < ApplicationController
  def new
  end

  def posts
    @posts = Content.where(type: 'post').paginate(page: params[:page])
  end
end
