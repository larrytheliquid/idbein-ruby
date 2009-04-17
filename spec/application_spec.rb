require "#{File.dirname(__FILE__)}/spec_helper"

context 'Application resource' do
  include Rack::Test::Methods
  def app() Application.new end
  
  describe 'GET /polls' do
    def do_get
      Poll.new(:title => 'Find me 1').save
      Poll.new(:title => 'Find me 2').save
      Poll.new(:title => 'Find me 3').save      
      get '/polls'
    end
    before { do_get }

    it { last_response.should be_successful }
    it { last_response.should have_selector('html') }
    
    it 'should return all polls' do
      last_response.should contain('Find me 1')
      last_response.should contain('Find me 2')
      last_response.should contain('Find me 3')      
    end
  end

  describe 'GET /polls/:id' do
    def do_get
      Poll.new(:title => 'Find me 1').save
      Poll.new(:title => 'Find me 2').save
      Poll.new(:title => 'Find me 3').save      
      get '/polls/find-me-2'
    end
    before { do_get }

    it { last_response.should be_successful }
    it { last_response.should have_selector('html') }
    
    it 'should return specified poll' do
      last_response.should_not contain('Find me 1')
      last_response.should contain('Find me 2')
      last_response.should_not contain('Find me 3')      
    end
  end

  describe 'POST /polls with valid attributes' do
    def do_post(attributes={})
      post '/polls', {:poll => poll_attributes(attributes)}
    end

    it { do_post; last_response.should be_redirect }

    it 'should create a new post that shows up in the list' do
      do_post(:title => 'Find me')
      follow_redirect!
      last_response.should contain('Find me')
    end
  end

  describe 'PUT /polls/:id/votes/:username' do
    def do_put
      @poll = new_poll(:title => 'Vote me')
      @poll.save
      new_user(:username => 'larrytheliquid').save
      put '/polls/vote-me/votes/larrytheliquid'
    end

    it { do_put; last_response.should be_successful }

    it 'should inform that a successful vote was cast' do
      do_put
      last_response.should contain("larrytheliquid successfully voted for 'Vote me'")
    end

    it 'should increment the number of votes in the poll' do
      pending 'User#vote!'
      do_put
      @poll.reload.votes.should == 1
    end
  end

  describe 'GET /users/new' do
    def do_get
      get '/users/new'
    end
    before { do_get }

    it { last_response.should be_successful }
    it { last_response.should have_selector('html') }
    
    it 'should return a signup form for users' do
      last_response.should contain('Signup')
    end
  end

  describe 'POST /users with valid attributes' do
    def do_post(attributes={})
      post '/users', {:user => user_attributes(attributes)}
    end

    it { do_post; last_response.should be_redirect }

    it 'should redirect to /polls page' do
      do_post(:title => 'Find me')
      last_response.location.should == '/polls'
    end
  end
end
