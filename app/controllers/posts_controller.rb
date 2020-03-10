class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy, :import]

  # GET /posts
  def index
    @post = Post.new
    @posts = search_and_tagged_posts(params)
                  .paginate(page: params[:page], per_page: 10)
    @tags = correct_posts.tag_counts_on(:tags)
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  def create
    session[:referrer] = request.referer if session[:referrer].nil?
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "'#{@post.title}' successfully created."
    else
      flash[:danger] = 'Failed to create new post.'
    end
    helpers.redirect_back_or posts_path
  end

  # PATCH/PUT /posts/1
  def update
    session[:referrer] = request.referer if session[:referrer].nil?
    if @post.update(post_params)
      flash[:success] = "'#{@post.title}' successfully updated."
    else
      flash[:danger] = "Failed to edit '#{@post.title}'."
    end
    helpers.redirect_back_or edit_post_path(@post)
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    flash[:success] = "'#{@post.title}' successfully deleted."
    redirect_to posts_url
  end

  def export
    @posts = search_and_tagged_posts(params)
    send_data @posts.to_json, filename: "posts_#{params[:q]}.json",
              type: :json
  end

  def import
    posts = JSON.parse(File.read(params[:json]))
    posts.each do |post|
      Post.create(post.to_h)
    end
    flash[:success] = "#{posts.size} posts successfully imported."
    redirect_back(fallback_location: posts_path)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :body, :tag_list, :public, :summary)
  end

  def correct_posts
    logged_in? ? Post.all.with_tags : Post.only_public.with_tags
  end

  def search_and_tagged_posts(params)
    if params[:q]
      tagged = correct_posts.tagged_with(params[:q]).unscope(:order).select(:id)
      searched = correct_posts.search_for(params[:q]).unscope(:order).select(:id)
      correct_posts.where(id: tagged).or(correct_posts.where(id: searched))
    elsif params[:tag]
      correct_posts.tagged_with(params[:tag])
    else
      correct_posts
    end
  end
end
