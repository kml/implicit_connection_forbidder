# encoding: utf-8

module Kernel
  def with_connection(&block)
    ::ActiveRecord::Base.connection_pool.with_connection(&block)
  end
end

