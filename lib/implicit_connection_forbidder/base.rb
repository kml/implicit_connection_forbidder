# encoding: utf-8

module ImplicitConnectionForbidder
  module Base
    def forbid_implicit_connections
      ::ActiveRecord::Base.connection_pool.release_connection
      Thread.current[:active_record_forbid_implicit_connections] = true
    end

    def allow_implicit_connections
      Thread.current[:active_record_forbid_implicit_connections] = false
    end

    def with_forbidden_implicit_connections
      forbid_implicit_connections
      yield
    ensure
      allow_implicit_connections
    end
  end
end

