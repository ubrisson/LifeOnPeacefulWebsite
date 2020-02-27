class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # Before filter: Confirms an admin user else redirects
  def admin_user
    unless admin?
      flash[:danger] = 'This action requires admin access'
      redirect_to root_url
    end
  end
end
