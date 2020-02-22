class ResourcesController < ApplicationController

  def index
    @resources = Resource.paginate(page: params[:page])
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      flash[:success] = "Resource created."
    else
      flash[:danger] = "Unable to create resource."
    end
    redirect_to resources_path
  end

  def update
  end

  def destroy
  end

  private
  def resource_params
    params.require(:resource).permit(:title, :author, :description, :link,
                                     :publication, :tag_list)
  end
end
