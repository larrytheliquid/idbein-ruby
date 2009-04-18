require 'application'
require 'spec/factory'
include Factory

SERVER.database(COUCHDB).delete!
SERVER.database(COUCHDB).create!
20.times { new_vote.save }
