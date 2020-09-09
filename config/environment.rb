require 'bundler'

Bundler.require

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/developtment.sqlite"
)

require_all 'app'
