# encoding: utf-8

module ImplicitConnectionForbidder
  module Base
    def forbid_implicit_connections
      begin
        ::ActiveRecord::Base.connection_pool.release_connection
      rescue ActiveRecord::ConnectionNotEstablished
      end

      old_value = Thread.current[:active_record_forbid_implicit_connections]
      Thread.current[:active_record_forbid_implicit_connections] = true
      return unless block_given?

      begin
        yield
      ensure
        Thread.current[:active_record_forbid_implicit_connections] = old_value
      end
    end

    def allow_implicit_connections
      old_value = Thread.current[:active_record_forbid_implicit_connections]
      Thread.current[:active_record_forbid_implicit_connections] = false
      return unless block_given?

      begin
        yield
      ensure
        Thread.current[:active_record_forbid_implicit_connections] = old_value

        if Thread.current[:active_record_forbid_implicit_connections] == true && Thread.current[:active_record_fresh_connection] != true
          ::ActiveRecord::Base.connection_pool.release_connection
        end
      end
    end
  end
end

