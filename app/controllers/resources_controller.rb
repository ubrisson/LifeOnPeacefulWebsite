# frozen_string_literal: true

class ResourcesController < ApplicationController
  before_action :admin_user, only: [:create, :edit, :update, :destroy, :import]

  def show
    @resource = correct_resources.find(params[:id])
  end

  def index
    @resource = Resource.new
    @resources = search_and_tagged_resources(params)
                 .paginate(page: params[:page], per_page: 10)
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

  def export
    @resources = search_and_tagged_resources(params)
    send_data @resources.to_json, filename: "resources_#{params[:q]}.json",
                                  type: :json
  end

  def import
    resources = JSON.parse(File.read(params[:json]))
    resources.each do |resource|
      Resource.create(resource.to_h)
    end
    flash[:success] = 'Resources imported'
    redirect_back(fallback_location: resources_path)
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :author, :description, :link,
                                     :publication, :tag_list, :public)
  end

  def correct_resources
    logged_in? ? Resource.all : Resource.only_public
  end

  def search_and_tagged_resources(params)
    if params[:q]
      tagged = correct_resources.tagged_with(params[:q]).unscope(:order)
      searched = correct_resources.search_for(params[:q]).unscope(:order)
      correct_resources
        .from("(#{tagged.to_sql} UNION #{searched.to_sql}) as Resources")
    elsif params[:tag]
      correct_resources.tagged_with(params[:tag])
    else
      correct_resources
    end
  end
end
