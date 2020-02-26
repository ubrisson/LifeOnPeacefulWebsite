# frozen_string_literal: true

class ResourcesController < ApplicationController
  before_action :admin_user, only: [:create, :edit, :update, :destroy]

  def show
    @resource = correct_resources.find(params[:id])
  end

  def index
    @resource = Resource.new
    @resources = if params[:q]
                   tagged = correct_resources.tagged_with(params[:q])
                   searched = correct_resources.search_for(params[:q])
                   # [0..-40] substracts the "Order by" clause within the queries
                   # This clause was causing a SQLite order before union exception
                   correct_resources
                     .from("(#{tagged.to_sql[0..-40]} UNION #{searched.to_sql[0..-40]}) as Resources")
                     .paginate(page: params[:page])
                 elsif params[:tag]
                   correct_resources.tagged_with(params[:tag]).paginate(page: params[:page])
                 else
                   correct_resources.paginate(page: params[:page])
                 end
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      flash[:success] = 'Resource created.'
    else
      flash[:danger] = 'Unable to create resource.'
    end
    redirect_to resources_path
  end

  def edit
    helpers.store_referrer
    @resource = Resource.find(params[:id])
  end

  def update
    session[:referrer] = request.referer if session[:referrer].nil?
    @resource = Resource.find(params[:id])
    if @resource.update(resource_params)
      flash[:success] = 'Resource edited'
      helpers.redirect_back_or @resource
    else
      flash[:danger] = 'Failed edition.'
      render 'resources/edit'
    end
  end

  def destroy
    Resource.delete(params[:id])
    flash[:success] = 'Resource deleted'
    redirect_to request.referrer || root_url
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :author, :description, :link,
                                     :publication, :tag_list, :public)
  end

  def correct_resources
    admin? ? Resource : Resource.only_public
  end
end
