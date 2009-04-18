class Poll < CouchRest::ExtendedDocument
  use_database SERVER.default_database
  include CouchRest::Validation

  unique_id :permalink
  property :title
  property :user_id
  property :description
  property :threshold
  property :votes_count
  timestamps!

  validates_present :title, :user_id

  view_by :updated_at, :descending => true

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
