class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # Before filter: Confirms an admin user else redirects
  def admin_user
    redirect_to(root_url) unless admin?
  end
end
