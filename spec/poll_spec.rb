require "#{File.dirname(__FILE__)}/spec_helper"

describe Poll do
  it 'should be valid by default' do
    new_poll.should be_valid
  end

  [:title, :description].each do |attr|
    it ".#{attr} should be a reader" do
      lambda { new_poll.send(attr) }.should_not raise_error
    end
  end

  it 'should require a title' do
    new_poll(:title => nil).should_not be_valid
  end
end

def new_poll(attributes={})
  Poll.new({:title => 'test poll',
            :description => 'test description'}.merge(attributes))
end
