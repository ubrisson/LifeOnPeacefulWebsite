class ContentPagesController < ApplicationController
  def index
    @resources = correct_content(Resource).all
    @quotes = correct_content(Quote).all
    @posts = correct_content(Post).all
  end

  def latest
    @resource = correct_content(Resource).last
    @quote = correct_content(Quote).last
    @post = correct_content(Post).last
  end

  private

  def correct_content(active_record)
    logged_in? ? active_record.all.with_tags : active_record.only_public.with_tags
  end
end
