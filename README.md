# Rambulance [![Build Status](https://travis-ci.org/yuki24/rambulance.svg?branch=master)](https://travis-ci.org/yuki24/rambulance)

Rambulance provides a simple and safe way to dynamically render error pages for Rails apps.

## Features

### Simple and Safe

Rambulance's exceptions app is simple, skinny and well-tested. It  inherits `ActionController::Base`, so it works fine even if your `ApplicationController` has an issue.

### Flexible

You have full control of what error page to display for a specific exception. It can also render json responses. It even provides a way to create a custom exceptions app.

### Easy installation and development

You don't have to configure things that every single person has to do and Rambulance does everything for you.

## Installation and Usage

Add this line to your application's Gemfile:

```
gem 'rambulance'
```

And then execute:

```
$ rails g rambulance:install
```

or specify the template engine by:
```
$ rails g rambulance:install -e slim
```

Rambulance now support `erb`, `haml`, `slim` template engines, if you don't specify the `-e` option, erb will be used as default.

Now you can start editing templates like `app/views/errors/not_found.html.erb`. Edit, run `rails server` and open [`localhost:3000/rambulance/not_found`](http://localhost:3000/rambulance/not_found)!

## Setting Pairs of Exceptions and HTTP Statuses

Open `config/initializers/rambulance.rb` and to configure the list of pairs of exception/corresponding http status.
For example, if you want to display:

 * 422(unprocessable entity) for `ActiveRecord::RecordNotUnique`
 * 403(forbidden) for `CanCan::AccessDenied`
 * 404(not found) for `YourCustomException`

Then do the following:

```ruby
# config/initializers/rambulance.rb
config.rescue_responses = {
  "ActiveRecord::RecordNotUnique" => :unprocessable_entity,
  "CanCan::AccessDenied"          => :forbidden,
  "YourCustomException"           => :not_found
}
```

## Local Development

There are 2 ways of editing the templates.

<!---
### Open [`localhost:3000/rambulance`](http://localhost:3000/rambulance) in Your Browser

This page tells all the error pages as well as all the pairs of exceptions/corresponding http status. This is useful when you want to edit templates without changing Rails configuration. Click on one of the links in the page to see what the error page looks like.

**This feature hasn't been implemented yet.**
-->

### Open `localhost:3000/rambulance/***` in Your Browser

Just go to one of the error pages via Rambulance:
 * [`localhost:3000/rambulance/not_found`](http://localhost:3000/rambulance/not_found) or
 * [`localhost:3000/rambulance/internal_server_error`](http://localhost:3000/rambulance/internal_server_error)

This is useful when you want to edit templates without changing Rails configuration.

### Set `consider_all_requests_local` to _false_

Change `config.consider_all_requests_local` to _false_ in `config/environments/development.rb`.

```
config.consider_all_requests_local = false
```

This simulates how your production app displays error pages so you can actually raise an exception in your app and see how it works. Don't forget to change `consider_all_requests_local` back to _true_ after you tried this strategy.

## Custom Exceptions App

If you want to do some more things in a exceptions app, you can also write your own custom exceptions app:

```
$ rails g rambulance:exceptions_app
```

It'll generate your own custom exceptions app. You can use whatever techniques you use in controllers like `before_filter` and `flash[:notice] = "message..."` since it's a grandchild of `ActionController::Base`!

**Keep in mind that you shouldn't do too many things because something already went wrong with your application!**

## Supported Versions

* Ruby 1.9.3, 2.0.0, 2.1, 2.2, JRuby 1.7.19, JRuby head, Rubinius 2.4.1 and 2.5.3
* Rails 3.2, 4.0, 4.1, 4.2 and edge

Rambulance doesn't work with Rails 3.1 and below since they don't provide any way to use a custom exceptions app.

## Contributing

1. Fork it ( https://github.com/yuki24/rambulance/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

Copyright (c) 2014-2015 Yuki Nishijima. See LICENSE.txt for further details.
