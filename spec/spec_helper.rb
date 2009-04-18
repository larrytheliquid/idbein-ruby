require 'rubygems'
require 'sinatra'
require 'spec'
require 'spec/interop/test'
require 'rack/test'
require 'webrat'
require 'faker'

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false
require 'application'

module Factory
  def poll_attributes(attributes={})
    {:title => Faker::Lorem.sentence,
     :description => Faker::Lorem.paragraph,
     :threshold => rand(10) + 1
    }.merge(attributes)
  end
  
  def new_poll(attributes={})
    Poll.new(poll_attributes attributes)
  end

  def user_attributes(attributes={})
    {:username => Faker::Internet.user_name,
     :email => Faker::Internet.email
    }.merge(attributes)
  end
  
  def new_user(attributes={})
    User.new(user_attributes attributes)
  end

  def vote_attributes(attributes={})
    user = new_user; user.save
    poll = new_poll; poll.save
    {:user_id => user.id,
     :poll_id => poll.id
    }.merge(attributes)
  end
  
  def new_vote(attributes={})
    Vote.new(vote_attributes attributes)
  end
  

end

Spec::Runner.configure do |config|
  config.include Webrat::Matchers, :type => :views
  config.include Factory

  config.before { SERVER.database(COUCHDB).create! rescue nil }
  config.after { SERVER.database(COUCHDB).delete! rescue nil }    
end
