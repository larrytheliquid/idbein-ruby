class Vote < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  include CouchRest::Validation

  unique_id :vote_hash
  property :user_id
  property :poll_id
  timestamps!

  validates_present :user_id, :poll_id

  def vote_hash
    self[:vote_hash] || "#{user_id}:#{poll_id}"
  end
end
