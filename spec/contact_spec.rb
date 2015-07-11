require 'rails_helper' #it requires this file that is in the same folder

#RSPEC you test the controller or the model while 'client unit test' is done for views
RSpec.describe StaticPagesController, :type => :controller do

	context "Contact should successfully be loaded" do

		it "should return status 200 when loaded" do
			get :contact #get to get the page you want
			expect(response).to have_http_status(200)
		 #expect(response.status).to eq(200) #equal way to test	
		end 
	end
end