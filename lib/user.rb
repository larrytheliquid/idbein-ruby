class User < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  include CouchRest::Validation

  unique_id :username
  property :username
  property :email
  timestamps!

  validates_present :username, :email

  def vote!(poll)
    Vote.new(:user_id => self.id, :poll_id => poll.id).save
    poll.votes_count += 1
    poll.save
  end
end
