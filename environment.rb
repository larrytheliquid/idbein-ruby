require 'rubygems'
require 'couchrest'

COUCHHOST  = "http://127.0.0.1:5984"
COUCHDB    = 'idbein'
SERVER     = CouchRest.new
SERVER.default_database = COUCHDB
