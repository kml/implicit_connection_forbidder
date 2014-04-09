# encoding: utf-8

module ActiveRecord
  class Base
    class << self
      def connection
        if Thread.current[:active_record_forbid_implicit_connections] && !Thread.current[:active_record_fresh_connection]
          raise ImplicitConnectionForbidder::ImplicitConnectionForbiddenError, "Implicit ActiveRecord connection is forbidden"
        end

        retrieve_connection
      end
    end
  end
end

