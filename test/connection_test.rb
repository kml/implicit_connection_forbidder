# encoding: utf-8

require_relative "test_helper"

require "implicit_connection_forbidder"
require "implicit_connection_forbidder/core_ext/kernel"

describe ImplicitConnectionForbidder do
  before do
    ImplicitConnectionForbidder.forbid_implicit_connections
  end

  it "API" do
    ImplicitConnectionForbidder.allow_implicit_connections

    query

    ImplicitConnectionForbidder.forbid_implicit_connections do
      proc { query }.must_raise ImplicitConnectionForbidder::ImplicitConnectionForbiddenError

      ImplicitConnectionForbidder.allow_implicit_connections do
        query
      end

      refute connection

      proc { query }.must_raise ImplicitConnectionForbidder::ImplicitConnectionForbiddenError
    end

    query

    ImplicitConnectionForbidder.forbid_implicit_connections

    proc { query }.must_raise ImplicitConnectionForbidder::ImplicitConnectionForbiddenError

    ImplicitConnectionForbidder.allow_implicit_connections do
      query
    end
  end

  it "query inside with_connection" do
    with_connection do
      assert connection
      query
      assert connection
    end

    refute connection
  end

  it "query inside allow_connection" do
    allow_connection do
      refute connection
      query
      assert connection
    end

    refute connection
  end

  it "with_connection inside with_connection" do
    with_connection do
      with_connection do
        assert connection
      end

      assert connection
    end

    refute connection
  end

  it "allow_connection inside with_connection" do
    with_connection do
      allow_connection do
        assert connection
      end

      assert connection
    end

    refute connection
  end

  it "with_connection inside allow_connection" do
    allow_connection do
      with_connection do
        assert connection
      end

      refute connection
    end

    refute connection

    allow_connection do
      query

      with_connection do
        assert connection
      end

      assert connection
    end

    refute connection
  end
end

