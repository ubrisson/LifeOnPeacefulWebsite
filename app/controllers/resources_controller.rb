class ResourcesController < ApplicationController

  def show
    @resource = Resource.find(params[:id])
  end

  def index
    @resources = Resource.paginate(page: params[:page])
    @resource = Resource.new
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
    store_location
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update(resource_params)
      flash[:success] = 'Resource edited'
      redirect_back_or @resource
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
