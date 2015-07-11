require 'rails_helper'

RSpec.describe UserController, :type => :controller do
	
	context "testing User Controller new.html.erb page"  do
		
		it "should return success code when acessing 'new' page" do
			get :new 
			expect(response.status).to eq(200)
		end
	end 
end
