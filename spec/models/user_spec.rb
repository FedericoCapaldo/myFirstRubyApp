require 'rails_helper'



RSpec.describe User, type: :model do
  #this is how to create an object 'user' of type User and then test it
  let(:user) { User.new(name: "Federico", email: "federico@kcl.uk") }

  it "should save the the user successfully" do 
  	 user.should respond_to(:save)
  	 user.save.should be_true
  end 

end
