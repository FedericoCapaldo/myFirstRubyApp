# class to manage HTTP sessions
class SessionsController < ApplicationController
  # open the page,  use the 'create' function to handle data form.
  def new
  end

  def create # post HTTP.
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid users credentials, please try again.'
      render 'new'
    end
  end

  def destroy
  end
end
