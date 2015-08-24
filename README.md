# ImplicitConnectionForbidder

ActiveRecord::ConnectionTimeoutError: could not obtain a database connection within 30 seconds (waited 30.0 seconds).
The max pool size is currently 1; consider increasing it.

This gem helps to detect calls of AR models, which are not within explicit with_connection block.
In those cases it throws an exception.
It's especially helpfull in the case where at the beginning of action AR model is selected from DB
and then other actions are performed that do not need DB (eg. querying mongo, generating JSON response, ...).
You can give back connection to the pool so other threads can use it.

Following block of code will raise an exception because of implicit AR connection:

    ImplicitConnectionForbidder.forbid_implicit_connections do
      User.first
    end

When using explicit connection (with_connection) it works fine:

    ImplicitConnectionForbidder.forbid_implicit_connections do
      ActiveRecord::Base.connection_pool.with_connection do
        User.first
      end
    end

Warning: When working with relation it is required to finish it with call to to_a.
In other case querying the database will be executed after with_connection block!

    ImplicitConnectionForbidder.forbid_implicit_connections do
      ActiveRecord::Base.connection_pool.with_connection do
        @users = User.all.to_a
      end
    end

## Installation

Add this line to your application's Gemfile:

    gem 'implicit_connection_forbidder', git: 'git://github.com/kml/implicit_connection_forbidder.git', require: [
      'implicit_connection_forbidder',
      'implicit_connection_forbidder/core_ext/kernel',
      'implicit_connection_forbidder/ext/action_controller/base'
    ]

And then execute:

    $ bundle install

## Inspiration

https://gist.github.com/jrochkind/1364551/raw/4922663a26568087d5a24b25a46ba426df98a36e/gistfile1.rb

## Contributing

1. Fork it ( http://github.com/<my-github-username>/implicit_connection_forbidder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

