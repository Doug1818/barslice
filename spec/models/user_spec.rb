require 'spec_helper'

describe User do
  
  let(:user) { FactoryGirl.create(:user) }
  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:reset_password_sent_at) }
  it { should respond_to(:remember_created_at) }
  it { should respond_to(:sign_in_count) }
  it { should respond_to(:current_sign_in_at) }
  it { should respond_to(:last_sign_in_at) }
  it { should respond_to(:current_sign_in_ip) }
  it { should respond_to(:last_sign_in_ip) }
  it { should respond_to(:admin) }
  it { should respond_to(:isbar) }
  it { should respond_to(:bar_id) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before { user.toggle!(:admin) }
    it { should be_admin }
  end

  describe "when email is not present" do
    before { user.email = "" }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { user.password = user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
  		addresses.each do |invalid_addresses|
  			user.email = invalid_addresses
  			user.should_not be_valid
  		end
  	end
  end

  describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_addresses|
  			user.email = valid_addresses
  			user.should be_valid
  		end
  	end
  end

# describe "when email address is already taken" do
#  	before do
#  		user_with_same_email = user.dup
#  		user_with_same_email.email = user.email.upcase
#       user_with_same_email.save
#  	end
#  
#  	it { should_not be_valid }
# end

  describe "when password is too short" do
    before { user.password = user.password_confirmation = "a"*5 }
    it { should_not be_valid }
  end
end
