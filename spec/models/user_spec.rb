require 'rails_helper'



RSpec.describe User, type: :model do
  #let(:user) { User.new(name: "Federico", email: "federico@kcl.uk") }

	context "data validation" do 
		#this allows to create a user for each it case without repeating it every time
		before(:each) do
			@user = User.new(name: "federico", email: "federico@gmail.uk", password: "chocol")
		end
	  
	  it "should report invalid user" do
	  	expect(@user.valid?).to eq(true)
	  end
	end
end
