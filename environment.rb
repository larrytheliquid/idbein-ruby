require 'rubygems'
require 'couchrest'

configure :development do
  APP        = 'http://localhost:9292'  
  COUCHHOST  = "http://127.0.0.1:5984"
  COUCHDB    = 'idbein-development'
  SERVER     = CouchRest.new
  SERVER.default_database = COUCHDB
end

configure :test do
  APP        = 'http://localhost:9292'
  COUCHHOST  = "http://127.0.0.1:5984"
  COUCHDB    = 'idbein-test'
  SERVER     = CouchRest.new
  SERVER.default_database = COUCHDB
end

configure :production do
  APP        = 'http://idbe.in'  
  COUCHHOST  = "http://127.0.0.1:5984"
  COUCHDB    = 'idbein'
  SERVER     = CouchRest.new
  SERVER.default_database = COUCHDB
end
