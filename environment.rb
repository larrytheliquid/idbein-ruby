require 'rubygems'
require 'couchrest'

configure :development do
  COUCHHOST  = "http://127.0.0.1:5984"
  COUCHDB    = 'idbein-development'
  SERVER     = CouchRest.new
  SERVER.default_database = COUCHDB
end

configure :test do
  COUCHHOST  = "http://127.0.0.1:5984"
  COUCHDB    = 'idbein-test'
  SERVER     = CouchRest.new
  SERVER.default_database = COUCHDB
end

configure :production do
  COUCHHOST  = "http://127.0.0.1:5984"
  COUCHDB    = 'idbein'
  SERVER     = CouchRest.new
  SERVER.default_database = COUCHDB
end
