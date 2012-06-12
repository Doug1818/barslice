require 'spec_helper'

describe Bar do
  
  let(:bar) { FactoryGirl.create(:bar) }
  subject { bar }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:address) }
  it { should respond_to(:neighborhood) }
  it { should respond_to(:phone) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { bar.name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { bar.email = "" }
    it { should_not be_valid }
  end

  describe "when address is not present" do
    before { bar.address = "" }
    it { should_not be_valid }
  end

  describe "when neighborhood is not present" do
    before { bar.neighborhood = "" }
    it { should_not be_valid }
  end

  describe "when phone is not present" do
    before { bar.phone = "" }
    it { should_not be_valid }
  end

  describe "when phone is not 10 ten digits"
  	before { bar.phone = "2"*7 }
  	it { should_not be_valid }
end
