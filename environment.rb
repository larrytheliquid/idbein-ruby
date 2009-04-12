require 'rubygems'
require 'couchrest'

configure :production, :development do
  COUCHHOST  = "http://127.0.0.1:5984"
  COUCHDB    = 'idbein'
  SERVER     = CouchRest.new
  SERVER.default_database = COUCHDB
end

configure :test do
  COUCHHOST  = "http://127.0.0.1:5984"
  COUCHDB    = 'idbein-test'
  SERVER     = CouchRest.new
  SERVER.default_database = COUCHDB
end
