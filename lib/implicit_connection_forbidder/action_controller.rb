# encoding: utf-8

module ImplicitConnectionForbidder
  module ActionController
    def self.included(base)
      base.class_eval do
        include ImplicitConnectionForbidder::Base
        private :forbid_implicit_connections
        private :allow_implicit_connections
        private :with_forbidden_implicit_connections

        around_filter :with_forbidden_implicit_connections
      end
    end
  end
end

