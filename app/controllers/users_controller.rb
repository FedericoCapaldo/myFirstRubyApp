class UsersController < ApplicationController

  def show 
  	@user = User.find(params[:id]) #this bit looks up for the right user when prompt to show info about the self user
  end


  def new
  end

end
