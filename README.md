# Rambulance [![Build Status](https://travis-ci.org/yuki24/rambulance.svg?branch=master)](https://travis-ci.org/yuki24/rambulance)

Rambulance provides a simple and safe way to dynamically render error pages for Rails apps.

## Features

### Simple and Safe

Rambulance's exceptions app is simple, skinny and well-tested. It  inherits `ActionController::Base`, so it just works fine even if your `ApplicationController` has an issue.

### Easy installation/development

You don't have to configure things that every single person has to do and Rambulance does everything for you.

### Flexible

You have full control of

## Installation and Usage

Add this line to your application's Gemfile:

```
gem 'rambulance'
```

And then execute:

```
$ rails g rambulance:install
```

Now you can start editing templates for error pages like `app/views/errors/not_found.html.erb`. Run `rails server` and go to [`localhost:3000/rambulance/not_found`](http://localhost:3000/rambulance/not_found)!

## Setting Pairs of Exceptions and HTTP Status

Open `config/initializers/rambulance.rb`.

## Local Development

There are 2 ways of incrementally editing the templates for error pages.

### Open [`localhost:3000/rambulance`](http://localhost:3000/rambulance) in your browser

This page tells all the error pages as well as all the pairs of exceptions/corresponding http status. This is useful when you want to edit templates without changing Rails configuration. Click on one of the links in the page to see what the error page looks like.

### Set `consider_all_requests_local` to _false_

Change `config.consider_all_requests_local` to _false_ in `config/environments/development.rb`.

```
config.consider_all_requests_local = false
```

This simulates how your production app displays so you can actually raise an exception in your app and see how it works. Don't forget to change `consider_all_requests_local` back to `true` after you tried this strategy.

## Custom Exceptions App

If you want to do some more things in a exceptions app, you can also write your own custom exceptions app:

```
$ rails g rambulance:exceptions_app
```

It'll generate your own custom exceptions app. You can use whatever techniques you use in controllers like `before_filter` and `flash[:notice] = "message..."` since it's a grandchild of `ActionController::Base`.

**Keep in mind that you shouldn't do too many things since something already went wrong with your application!**

## Supported Versions

* Ruby 1.9.3, 2.0.0, 2.1.2, JRuby 1.7.11, Rubinius 2.2.6
* Rails 3.2, 4.0, 4.1

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rambulance/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

Copyright (c) 2014 Yuki Nishijima. See LICENSE.txt for further details.
