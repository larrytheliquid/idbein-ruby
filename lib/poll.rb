class Poll < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  include CouchRest::Validation

  property :title
  property :description

  validates_present :title
end
