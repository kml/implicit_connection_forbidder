# encoding: utf-8

module ImplicitConnectionForbidder
  class Filter
    def self.filter(controller, &block)
      ImplicitConnectionForbidder.forbid_implicit_connections(&block)
    end
  end
end

