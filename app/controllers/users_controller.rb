class UsersController < ApplicationController

  def show 
  	@user = User.find(params[:id]) #this bit looks up for the right user when prompt to show info about the self user
  end


  def new
  	@user = User.new
  end

  def create 
  	@user = User.new(user_params) #to create with greater detail.

  	if @user.save
  		#handle successful signup
  	else
  		render 'new'
		end
  end


  private
	  
	  #remember the implicit return of the last statement
	  def user_params 
	  	params.require(:user).permit(:name, :email, :password, 
	  								:password_confirmation)
	  end

end
