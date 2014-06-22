# encoding: utf-8

ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

require "pry"

gem "minitest"
require "minitest/autorun"

def connection
  ActiveRecord::Base.connection_pool.active_connection?
end

def query
  ActiveRecord::Base.connection.execute "select 1"
end

