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
      params[:session][:remember_me] == 1 ? remember(user) : forget(user)
      # this saves the cookie: permanent = for 20 years, signed = encrypted.
      redirect_to user # redirect to "view profile", calling show function.
      # through resources :users (I guess).
    else
      flash.now[:danger] = 'Invalid users credentials, please try again.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'Successfully Logged Out.' # use flash.now if you render
    # and not if you redirect, because in that case flash would last more than
    # needed.
    redirect_to root_path
  end
end
