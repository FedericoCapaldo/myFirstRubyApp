# class to manage HTTP sessions
class SessionsController < ApplicationController
  # open the page,  use the 'create' function to handle data form.
  def new
  end

  def create # post HTTP when a session is created.
    user = User.find_by(email: params[:session][:email].downcase)

    # if the user exists and the password matches, log in
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user # redirect to "view profile", calling show function.
      # through resources :users (I guess).
    else
      flash.now[:danger] = 'Invalid users credentials, please try again.'
      render 'new'
    end
  end

  def destroy
    log_out
    flash.now[:success] = 'Successfully Logged Out.'
    redirect_to root_path
  end
end
