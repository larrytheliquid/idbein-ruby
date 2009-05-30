require "#{File.dirname(__FILE__)}/spec_helper"

describe Vote do
  it 'should be valid by default' do
    new_vote.should be_valid
  end

  [:user_id, :poll_id].each do |attr|
    it ".#{attr} should be a String reader" do
      new_vote.send(attr).should be_kind_of(String)
    end
  end

  it 'should require a user_id' do
    new_vote(:user_id => nil).should_not be_valid
  end

  it 'should require a poll_id' do
    new_vote(:poll_id => nil).should_not be_valid
  end

  it 'should use user_id+poll_id' do
    poll = new_vote(:user_id => 'larrytheliquid', :poll_id => 'find-me')
    poll.save
    poll.id.should == 'larrytheliquid:find-me'
  end
end
