require 'faker'
require 'sham' # via notahat-machinist

Sham.define do
  title { Faker::Lorem.sentence.chomp('.') }
  description { Faker::Lorem.paragraph }
  threshold { rand(100).next }
  username { Faker::Internet.user_name }
  email { Faker::Internet.email }
end

module Factory
  def poll_attributes(attributes={})
    result = {
      :title => Sham.title,
      :description => Sham.description,
      :threshold => Sham.threshold
    }.merge(attributes)
    unless result.has_key? :user_id
      user = new_user; user.save!
      result[:user_id] = user.id
    end
    result
  end
  
  def new_poll(attributes={})
    Poll.new poll_attributes(attributes)
  end

  def user_attributes(attributes={})
    {:username => Sham.username,
     :email => Sham.email
    }.merge(attributes)
  end
  
  def new_user(attributes={})
    User.new user_attributes(attributes)
  end

  def vote_attributes(attributes={})
    result = Hash.new.merge(attributes)
    unless result.has_key? :user_id
      user = new_user; user.save!
      result[:user_id] = user.id
    end
    unless result.has_key? :poll_id
      poll = new_poll; poll.save!
      result[:poll_id] = poll.id
    end
    result
  end
  
  def new_vote(attributes={})
    Vote.new vote_attributes(attributes)
  end
end
