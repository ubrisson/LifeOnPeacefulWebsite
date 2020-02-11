class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def welcome
    render html: 'Welcome Home'
  end
end
