class TikasController < ApplicationController

  before_action :set_tika, only: [:edit, :update, :destroy]
  before_action :admin_user

  def index
    @tika = Tika.new
    @tikas = Tika.roots
  end

  def create
    session[:referrer] = request.referer if session[:referrer].nil?
    @tika = Tika.new(tika_params)
    if @tika.save
      flash[:success] = "'#{@tika.title}' successfully created."
    else
      flash[:danger] = 'Failed to create new tika.'
    end
    helpers.redirect_back_or tikas_path
  end

  def edit
    helpers.store_referrer
  end

  def update
    session[:referrer] = request.referer if session[:referrer].nil?
    if @tika.update(tika_params)
      flash[:success] = "'#{@tika.title}' successfully updated."
      helpers.redirect_back_or tikas_path
    else
      flash[:danger] = "Failed to edit '#{@tika.title}'."
      render 'tikas/edit'
    end
  end

  def destroy
    @tika.destroy
    flash[:success] = "'#{@tika.title}' successfully deleted."
    redirect_to tikas_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tika
    @tika = Tika.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tika_params
    params.require(:tika).permit(:title, :link, :year, :parent_id)
  end
end
