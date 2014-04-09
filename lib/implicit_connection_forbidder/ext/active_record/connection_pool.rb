# encoding: utf-8

module ActiveRecord
  module ConnectionAdapters
    class ConnectionPool
      def with_connection
        connection_id = current_connection_id
        fresh_connection = true unless active_connection?
        Thread.current[:active_record_fresh_connection] = fresh_connection
        yield connection
      ensure
        release_connection(connection_id) if fresh_connection
        Thread.current[:active_record_fresh_connection] = nil
      end
    end
  end
end

