class Poll < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  include CouchRest::Validation

  unique_id :permalink
  property :title
  property :description
  property :threshold
  property :votes_count
  timestamps!

  validates_present :title

  def permalink
    self[:id] || title.downcase.split(' ').join('-')
  end

  def threshold
    self[:threshold] || 5
  end

  def votes_count
    self[:votes_count] || 0
  end
end
