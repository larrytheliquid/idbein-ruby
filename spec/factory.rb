require 'faker'

module Factory
  def poll_attributes(attributes={})
    {:title => Faker::Lorem.sentence,
     :description => Faker::Lorem.paragraph,
     :threshold => rand(10) + 1
    }.merge(attributes)
  end
  
  def new_poll(attributes={})
    Poll.new poll_attributes(attributes)
  end

  def user_attributes(attributes={})
    {:username => Faker::Internet.user_name,
     :email => Faker::Internet.email
    }.merge(attributes)
  end
  
  def new_user(attributes={})
    User.new user_attributes(attributes)
  end

  def vote_attributes(attributes={})
    user = new_user; user.save
    poll = new_poll; poll.save
    {:user_id => user.id,
     :poll_id => poll.id
    }.merge(attributes)
  end
  
  def new_vote(attributes={})
    Vote.new vote_attributes(attributes)
  end
end
