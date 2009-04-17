class User < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  include CouchRest::Validation

  unique_id :username
  property :username
  property :email
  timestamps!

  validates_present :username
  validates_present :email  
end
