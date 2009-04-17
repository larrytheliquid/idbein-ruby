require "#{File.dirname(__FILE__)}/spec_helper"

describe User do
  it 'should be valid by default' do
    new_user.should be_valid
  end

  [:username, :email].each do |attr|
    it ".#{attr} should be a reader" do
      lambda { new_user.send(attr) }.should_not raise_error
    end
  end

  it 'should require a username' do
    new_user(:username => nil).should_not be_valid
  end

  it 'should require an email' do
    new_user(:email => nil).should_not be_valid
  end

  it 'should use username as id' do
    user = new_user(:username => 'larrytheliquid')
    user.save
    user.id.should == 'larrytheliquid'
  end
end
