# ImplicitConnectionForbidder

Patch pomaga wykryć wywołania modeli AR, które nie znajdują się wewnątrz bloku with_connection
i rzuca dla nich wyjątek.
W przypadku akcji, gdzie na początku pobierany jest model AR,
następnie wykonywane są inne akcje (np. odpytania mongo, generowanie odpowiedzi)
można oddać połączenie do puli, aby inne akcje z niego korzystały.

Szczególnie przydatny w środowisku development i test.

Poniższy blok rzuci wyjątkiem:

    Shop.first

Zapis wewnątrz with_connection działa bezproblemowo:

    ActiveRecord::Base.connection_pool.with_connection do
      Shop.first
    end

Uwaga: Jeśli pracujemy z relacją należy zakończyć ją wywołaniem to_a,
inaczej próba komunikacji z bazą wystąpi poza blokiem with_connection!

    ActiveRecord::Base.connection_pool.with_connection do
      @shops = Shop.all.to_a
    end

Patch podpinamy w kontrolerze dodając odpowiednie filtry.

    class ApplicationController < ActionController::Base
      include ImplicitConnectionForbidder::ActionController
    end

Jako middleware:

    Rails.application.middleware.use ImplicitConnectionForbidder::Middleware

## Installation

Add this line to your application's Gemfile:

    gem 'implicit_connection_forbidder'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install implicit_connection_forbidder

Add require statements (ex. config/initializers/implicit_connection_forbidder.rb)

    require 'implicit_connection_forbidder'
    require 'implicit_connection_forbidder/core_ext/kernel'
    require 'implicit_connection_forbidder/ext/action_controller/base'

## Inspiration

https://gist.github.com/jrochkind/1364551/raw/4922663a26568087d5a24b25a46ba426df98a36e/gistfile1.rb

## Contributing

1. Fork it ( http://github.com/<my-github-username>/implicit_connection_forbidder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

