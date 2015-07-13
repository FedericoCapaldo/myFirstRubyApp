require 'rails_helper'

RSpec.describe User, type: :model do
  # remember that you are testing a model and therefore you can't test things
  # like the HTTP status as you would in testing a view.

  context 'valid data input for sign up' do
    # this allows to create a user for each it case.
    before(:each) do
      @user = User.new(name: 'federico', email: 'federico@gmail.uk',
                       password: 'choco12l')
    end

    it 'should report invalid user' do
      expect(@user.valid?).to eq(true)
    end
  end

  context 'invalid data input for sign up' do
    it 'should discard blank name field' do
      user = User.new(name:  '     ', email:  'fede@gmail.com  ',
                      password:   'sec1r4p4ssw0rd',
                      password_confirmation: 'sec1r4p4ssw0rd')
      expect(user.valid?).to eq(false)
    end

    it 'should discard passwords that dont match' do
      user = User.new(name:  'Username21', email:  'fede@gmail.com',
                      password: 'sec1r4p4ssw0rd',
                      password_confirmation: 'secewwwrwerwerw')
      expect(user.valid?).to eq(false)
    end

    it 'should discard blank email' do
      user = User.new(name:  'Username21', email:  '    ',
                      password:   'sec1r4p4ssw0rd',
                      password_confirmation:   'sec1r4p4ssw0rd')
      expect(user.valid?).to eq(false)
    end
  end
end
