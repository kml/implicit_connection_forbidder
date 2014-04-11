# encoding: utf-8

class ActionController::Base
  include ImplicitConnectionForbidder::ActionController
end

