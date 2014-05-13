# encoding: utf-8

module ImplicitConnectionForbidder
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      ImplicitConnectionForbidder.forbid_implicit_connections do
        @app.call(env)
      end
    end
  end
end

