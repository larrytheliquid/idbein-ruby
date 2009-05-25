class User < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  include CouchRest::Validation

  unique_id :username
  property :username
  property :email
  timestamps!

  validates_present :username
  validates_present :email  

  def vote!(poll)
    vote = Vote.new(:user_id => self.id, :poll_id => poll.id)
    unless (Vote.get(vote.vote_hash) rescue nil)
      vote.save
      poll.votes_count += 1
      poll.save
    end
  end
end
