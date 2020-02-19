class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    elsif user
      flash.now[:danger] = 'Invalid password'
      render 'new'
    else
      flash.now[:danger] = 'Invalid name'
      render 'new'
    end
  end

  def destroy
  end
end
