require "#{File.dirname(__FILE__)}/spec_helper"

describe Poll do
  it 'should be valid by default' do
    new_poll.should be_valid
  end

  [:title, :description].each do |attr|
    it ".#{attr} should be a String reader" do
      new_poll.send(attr).should be_kind_of(String)
    end
  end

  [:threshold].each do |attr|
    it ".#{attr} should be an Integer reader" do
      new_poll.send(attr).should be_kind_of(Integer)
    end
  end

  it 'should require a title' do
    new_poll(:title => nil).should_not be_valid
  end

  it 'should be 5 by default' do
    Poll.new.threshold.should == 5
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
