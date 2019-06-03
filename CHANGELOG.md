## [v1.0.0](https://github.com/yuki24/rambulance/tree/v1.0.0)

_<sup>released at 2019-06-03 05:01:14 UTC</sup>_

#### Features

- Add support for Ruby 2.6
- Add support for Rails 6.0

#### Bug fixes

- Fixes a bug where POST requests cause the exceptions app to throw an `ActionController::InvalidAuthenticityToken` error on Rails 5.2 ([<tt>d68d677</tt>](https://github.com/yuki24/rambulance/commit/d68d677de75059fa09f70e37c97f4bae95885c53), [#48](https://github.com/yuki24/rambulance/issues/48), [@adrianhuna](https://github.com/adrianhuna))

#### Breaking Changes

- Drop support for Ruby \<= 2.2
- Drop support for Rails \<= 4.1

## [v0.6.0](https://github.com/yuki24/rambulance/tree/v0.6.0)

_<sup>released at 2018-03-08 18:36:16 UTC</sup>_

#### New features

- Add support for Rails 5.2
- Add a test helper method `#with_exceptions_app` for easier testing ([<tt>f5c16b9</tt>](https://github.com/yuki24/rambulance/commit/f5c16b90ecf5eb4903faa30d760bf5863441e9c5), [#27](https://github.com/yuki24/rambulance/pull/27), [@kbaba1001](https://github.com/kbaba1001))

#### Bug fixes

- Fixed a bug where an `ActionController::UnknownFormat` error could cause a number of issues ([<tt>1b824e6</tt>](https://github.com/yuki24/rambulance/commit/1b824e6c170479ed90e24df1680dd2dec7c98160), [#41](https://github.com/yuki24/rambulance/issues/41), [#42](https://github.com/yuki24/rambulance/pull/42), [@willnet](https://github.com/willnet), [@joker-777](https://github.com/joker-777))
- Fixed a bug where the methods on the `ExceptionApp` weren't easily inspectable ([<tt>6b4c834</tt>](https://github.com/yuki24/rambulance/commit/6b4c834bb0b8e81f619d9f598310ce68f4f9c66b))

## [v0.5.0](https://github.com/yuki24/rambulance/tree/v0.5.0)

_<sup>released at 2018-01-02 21:36:02 UTC</sup>_

#### New features

- Add support for Ruby 2.5.0
- Add support for Rails 5.1

#### Breaking changes & deprecations

- Drop support for Ruby 1.9.3
- Drop support for generating Haml and Slim templates on `rails g rambulance:install`

#### Bug fixes

- Fixes a bug where the exceptions app fails to show an error page properly when a malformed body is posted ([<tt>474b6b3</tt>](https://github.com/yuki24/rambulance/commit/474b6b329e5590db3c0a7e33c795b18c00812729), [#40](https://github.com/yuki24/rambulance/issues/40), [@jasim](https://github.com/jasim))

## [v0.4.0](https://github.com/yuki24/rambulance/tree/v0.4.0)

_<sup>released at 2016-10-12 02:25:55 UTC</sup>_

- Added support for Rails 5 and edge
- Added the ability to use helper methods in error templates([@willnet](https://github.com/willnet), [#37](https://github.com/yuki24/rambulance/pull/37))

## [v0.3.1](https://github.com/yuki24/rambulance/tree/v0.3.1)

_<sup>released at 2015-05-18 01:53:59 UTC</sup>_

- Added slim support ([@liubin](https://github.com/liubin), [#20](https://github.com/yuki24/rambulance/pull/20))
- `rails g rambulance:install` no longer generates jbuilder templates if it's undefined
- The exceptions app no longer attempts to render layouts when the request format is json
- Now `rails g rambulance:install` always copies `application.html.erb` to `error.html.erb` again
- **incompatible change** : `error_layout` option for the install command has been removed in favor of the change above

## [v0.3.0](https://github.com/yuki24/rambulance/tree/v0.3.0)

_<sup>released at 2015-01-23 13:42:35 UTC</sup>_

- Added 2 helper methods `#exception` and `#status_in_words` that you can use in views

## [v0.2.0](https://github.com/yuki24/rambulance/tree/v0.2.0)

_<sup>released at 2014-09-18 03:38:18 UTC</sup>_

- Add support for Rails 4.2 beta
- Do not copy application.html.erb when `rails g rambulance:install` [[@kenn](https://github.com/kenn), [#5](https://github.com/yuki24/rambulance/issues/5)]
- Capture `ActionController::BadRequest` before processing action
- Dynamically generate exception/status mapping in initializer
- Add option to copy `application.html.erb` for error page layout

## [v0.1.2](https://github.com/yuki24/rambulance/tree/v0.1.2)

_<sup>released at 2014-09-05 12:22:37 UTC</sup>_

- Fixed a bug where changing config.layout\_name doesn't actually switch layout [[@kenn](https://github.com/kenn), [#4](https://github.com/yuki24/rambulance/issues/4)]
- Exceptions app now refers to `app/views/#{config.view_path}` by default

## [v0.1.1](https://github.com/yuki24/rambulance/tree/v0.1.1)

_<sup>released at 2014-06-22 02:39:06 UTC</sup>_

- Fixed a bug where installer command doesn't work

## [v0.1.0](https://github.com/yuki24/rambulance/tree/v0.1.0)

_<sup>released at 2014-06-20 01:00:02 UTC</sup>_

- First release of rambulance!
