require 'bundler'
require "sinatra/activerecord"

Bundler.require

# New version of sinatra-activerecord uses this setup line
set :database, {adapter: "sqlite3", database: "db.sqlite3"}

require_all 'app'
