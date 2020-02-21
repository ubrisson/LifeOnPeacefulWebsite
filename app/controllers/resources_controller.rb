class ResourcesController < ApplicationController

  def index
    @resources = Resource.paginate(page: params[:page])
  end

  def create
  end

  def update
  end

  def destroy
  end

end
