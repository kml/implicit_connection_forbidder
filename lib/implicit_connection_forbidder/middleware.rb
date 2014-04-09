# encoding: utf-8

module ImplicitConnectionForbidder
  class Middleware
    include ImplicitConnectionForbidder::Base

    def initialize(app)
      @app = app
    end

    def call(env)
      with_forbidden_implicit_connections do
        @app.call(env)
      end
    end
  end
end

