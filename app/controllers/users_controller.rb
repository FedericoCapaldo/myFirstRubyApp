# this class is a controller for users
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) # this bit looks up for the right user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) # to create with greater detail.

    if @user.save
      # handle successful signup
      flash[:success] = "Welcome to your new 'Sample_app' account!!"
      redirect_to @user #== redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private

  # remember the implicit return of the last statement
  def user_params
    # these are STRONG parameters, it is secure, because you allow only
    # the paramenters that you name. this avoids manipulation of the database.
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
