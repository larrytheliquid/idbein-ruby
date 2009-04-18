require 'application'
require 'spec/factory'
include Factory

SERVER.database(COUCHDB).recreate!
20.times { new_vote.save }
