# frozen_string_literal: true

class ResourcesController < ApplicationController
  def show
    @resource = Resource.find(params[:id])
  end

  def index
    @resource = Resource.new
    @resources = if params[:q]
                   Resource.search_for(params[:q]).paginate(page: params[:page])
                 elsif params[:tag]
                   Resource.tagged_with(params[:tag]).paginate(page: params[:page])
                 else
                   Resource.paginate(page: params[:page])
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
                                     :publication, :tag_list)
  end
end
