require "#{File.dirname(__FILE__)}/spec_helper"

describe Poll do
  it 'should be valid by default' do
    new_poll.should be_valid
  end

  [:title, :description, :user_id].each do |attr|
    it ".#{attr} should be a String reader" do
      new_poll.send(attr).should be_kind_of(String)
    end
  end

  [:threshold, :votes_count].each do |attr|
    it ".#{attr} should be an Integer reader" do
      new_poll.send(attr).should be_kind_of(Integer)
    end
  end

  it 'should require a title' do
    new_poll(:title => nil).should_not be_valid
  end

  it 'should require a user_id' do
    new_poll(:user_id => nil).should_not be_valid
  end

  it 'should have a default threshold of 5' do
    Poll.new.threshold.should == 5
  end

  it 'should have a default votes_count of 0' do
    Poll.new.votes_count.should == 0
  end

  context 'creating permalink id from title' do
    it 'should do nothing for all-lowercase strings without spaces' do
      poll = new_poll(:title => 'lowercasenospaces')
      poll.save
      poll.id.should == 'lowercasenospaces'
    end
    
    it 'should lowercase when title has upper case letters' do
      poll = new_poll(:title => 'lowErcAsenoSPaceS')
      poll.save
      poll.id.should == 'lowercasenospaces'
    end
    
    it 'should dasherize when title has spaces' do
      poll = new_poll(:title => 'lowercase with spaces')
      poll.save
      poll.id.should == 'lowercase-with-spaces'
    end
  end
end

describe Poll, '.by_updated_at' do
  it 'should order by created_at descending' do
    old = new_poll; old.save
    sleep(1)
    recent = new_poll; recent.save
    Poll.by_updated_at.first.should == Poll.get(recent.id)
  end
end
