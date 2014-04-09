# encoding: utf-8

require "implicit_connection_forbidder/version"
require "implicit_connection_forbidder/base"
require "implicit_connection_forbidder/action_controller"

require "implicit_connection_forbidder/ext/active_record/base"
require "implicit_connection_forbidder/ext/active_record/connection_pool"

module ImplicitConnectionForbidder
  ImplicitConnectionForbiddenError = Class.new(StandardError)
  extend Base
end

