require "#{File.dirname(__FILE__)}/spec_helper"

context 'Application resource' do
  include Rack::Test::Methods
  def app() Application.new end
  
  describe 'GET /polls' do
    def do_get
      new_poll(:title => 'Find me 1').save
      new_poll(:title => 'Find me 2').save
      new_poll(:title => 'Find me 3').save      
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
  
  describe 'GET /polls/new' do
    def do_get
      get '/polls/new'
    end
    before { do_get }
  
    it { last_response.should be_successful }
    it { last_response.should have_selector('html') }
    it { last_response.should contain('Add') }
  end

  describe 'GET /polls/:permalink' do
    def do_get
      new_poll(:title => 'Find me 1').save
      new_poll(:title => 'Find me 2').save
      new_poll(:title => 'Find me 3').save      
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

  # TODO: add .fragment
  describe 'GET /polls/:permalink/votes/:username.fragment' do
    def do_get
      get '/polls/vote-me/votes/larrytheliquid.fragment'
    end
    
    before do
      @poll = new_poll(:title => 'Vote me'); @poll.save
      @user = new_user(:username => 'larrytheliquid'); @user.save
    end

    context 'when a poll has not been voted for' do
      before { do_get }

      it { last_response.should be_successful }

      it 'should return novote markup fragment' do
        last_response.should have_selector(:div, :class => 'novote')
        last_response.should contain("I'm not in")
      end      
    end

    context 'when a poll has already been voted for' do
      before { @user.vote!(@poll); do_get }

      it { last_response.should be_successful }

      it 'should return voted markup fragment' do
        last_response.should have_selector(:div, :class => 'voted')
        last_response.should contain("I'm in!")
      end            
    end
  end

  describe 'PUT /polls/:permalink/votes/:username' do
    before do
      @poll = new_poll(:title => 'Vote me')
      @poll.save
      new_user(:username => 'larrytheliquid').save
    end
    
    def do_put
      put '/polls/vote-me/votes/larrytheliquid'
    end

    context 'when a poll has not been voted for' do
      it { do_put; last_response.should be_successful }

      it 'should inform that a successful vote was cast' do
        do_put
        last_response.should contain("larrytheliquid successfully voted for 'Vote me'")
      end

      it 'should increment the number of votes in the poll' do
        do_put
        Poll.get(@poll.id).votes_count.should == 1
      end
    end

    context 'when a poll has already been voted for' do
      it { 2.times { do_put }; last_response.should be_successful }

      it 'should inform that a successful vote was cast' do
        2.times { do_put }
        last_response.should contain("larrytheliquid successfully voted for 'Vote me'")
      end

      it 'should not increment the number of votes in the poll' do
        2.times { do_put }
        Poll.get(@poll.id).votes_count.should == 1
      end
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
