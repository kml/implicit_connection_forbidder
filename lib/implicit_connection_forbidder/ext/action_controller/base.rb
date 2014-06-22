# encoding: utf-8

require "implicit_connection_forbidder/filter"

class ActionController::Base
  around_filter ImplicitConnectionForbidder::Filter
end

