class Poll < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  include CouchRest::Validation

  unique_id :permalink
  property :title
  property :description
  timestamps!

  validates_present :title

  def permalink
    title.downcase.split(' ').join('-')
  end
end
