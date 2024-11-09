## Unreleased

#### 🚨 Breaking Changes

- No changes.

#### ⭐️ New Features

- Add support for Rails 8.0 ([<tt>#81</tt>](https://github.com/yuki24/rambulance/pull/81))

#### 🐞 Bug Fixes

- No changes.

## [v3.3.0](https://github.com/yuki24/rambulance/tree/v3.3.0)

_<sup>released at 2024-08-16 05:32:59 UTC</sup>_

#### New Features

- Add support for Rails 7.1 ([<tt>e6d42b5</tt>](https://github.com/yuki24/rambulance/commit/e6d42b514d0bdbc2ea5b1603f85ecc9fa24b819a))

## [v3.2.0](https://github.com/yuki24/rambulance/tree/v3.2.0)

_<sup>released at 2024-08-04 03:04:26 UTC</sup>_

This release includes a **breaking change**. Please read the details below carefully.

#### New Features

- Fixed compatibility with Rack (see [rack/rack#2137](https://github.com/rack/rack/pull/2137)) ([#77](https://github.com/yuki24/rambulance/issues/77), [@tmaier](https://github.com/tmaier), [#78](https://github.com/yuki24/rambulance/pull/78))

#### Breaking Changes

The Rack compatibility fix is related to Rack becoming more compliant with the IANA HTTP Status Code Registry.  
As a result:

- `unprocessable_entity` has been renamed to `unprocessable_content`.
- Rambulance will redirect any request from `unprocessable_entity` to `unprocessable_content` for backward compatibility.
- Users **must** rename the view file from `app/views/errors/unprocessable_entity.html.erb` to `app/views/errors/unprocessable_content.html.erb`.
- Users **should** update the hash values in their configurations: Change `unprocessable_entity` to `unprocessable_content` in `config.rescue_responses`/`config.action_dispatch.rescue_responses`

## [v3.1.0](https://github.com/yuki24/rambulance/tree/v3.1.0)

_<sup>released at 2024-01-04 10:08:11 UTC</sup>_

#### New Features

- The test helper is now compatible with Rails Edge (8.0) ([#73](https://github.com/yuki24/rambulance/pull/73), [#75](https://github.com/yuki24/rambulance/pull/75))
- Add support for Ruby 3.3 ([#74](https://github.com/yuki24/rambulance/pull/74))

## [v3.0.0](https://github.com/yuki24/rambulance/tree/v3.0.0)

_<sup>released at 2023-09-22 14:47:24 UTC</sup>_

#### New Features

- Add support for Rails 7.1 ([<tt>be6f129</tt>](https://github.com/yuki24/rambulance/commit/be6f129dd4c1d190e90a3036f7f1099028ef4a1e))

#### Breaking Changes

- Drop support for Ruby 2.3 and 2.4 ([<tt>c0d3439</tt>](https://github.com/yuki24/rambulance/commit/c0d3439d64552a88cb934d57bc57d2c06ff593c9))

## [v2.3.0](https://github.com/yuki24/rambulance/tree/v2.3.0)

_<sup>released at 2023-01-05 05:33:36 UTC</sup>_

#### New Features

- Ruby 3.2 is now officially supported.

## [v2.2.0](https://github.com/yuki24/rambulance/tree/v2.2.0)

_<sup>released at 2022-02-13 07:56:32 UTC</sup>_

#### Features

- Add support for Ruby 3.1, Rails 7.0 and JRuby 9.3.3.0

## [v2.0.0](https://github.com/yuki24/rambulance/tree/v2.0.0)

_<sup>released at 2021-09-22 02:49:18 UTC</sup>_

#### Breaking Changes

- Drop support for Rails 4.1 and older ([#62](https://github.com/yuki24/rambulance/pull/62), [@yuki24](https://github.com/yuki24))

#### Features

- Add support for Rails 6.1 and Ruby 3.0 ([#61](https://github.com/yuki24/rambulance/pull/61), [#63](https://github.com/yuki24/rambulance/pull/63), [@gingerlime](https://github.com/gingerlime), [@yuki24](https://github.com/yuki24))

#### Bug fixes

- POST with invalid JSON triggers a 500 ([#59](https://github.com/yuki24/rambulance/pull/59), [@gingerlime](https://github.com/gingerlime))
- Fix 'directry' typo ([#57](https://github.com/yuki24/rambulance/pull/57), [@andyw8](https://github.com/andyw8))

## [v1.1.1](https://github.com/yuki24/rambulance/tree/v1.1.1)

_<sup>released at 2020-05-28 23:22:10 UTC</sup>_

#### Bug fixes

- Fixes a bug where a malformed `Content-Type` header could break the exceptions app ([#55](https://github.com/yuki24/rambulance/pull/55), [@gingerlime](https://github.com/gingerlime))

## [v1.1.0](https://github.com/yuki24/rambulance/tree/v1.1.0)

_<sup>released at 2020-05-23 02:52:27 UTC</sup>_

#### Features

- Add support for Ruby 2.7 ([<tt>718531c</tt>](https://github.com/yuki24/rambulance/commit/718531c45b61d01dce91f401fd81dd6aefdefb31))

#### Bug fixes

- Fixes a bug where malformed MIME type in HTTP headers could break the exceptions app ([#53](https://github.com/yuki24/rambulance/issues/53), [#54](https://github.com/yuki24/rambulance/pull/54), [@gingerlime](https://github.com/gingerlime))

## [v1.0.3](https://github.com/yuki24/rambulance/tree/v1.0.3)

_<sup>released at 2019-10-03 03:39:17 UTC</sup>_

#### Fixes

- Fixes a bug where custom exceptions app can not be loaded properly on Rails 6 and Zeitwerk ([#52](https://github.com/yuki24/rambulance/issues/52), [@sho918](https://github.com/sho918))

## [v1.0.2](https://github.com/yuki24/rambulance/tree/v1.0.2)

_<sup>released at 2019-06-06 23:39:38 UTC</sup>_

#### Fixes

- Fixes a bug where `ExceptionsApp` is not loaded when action controller is not loaded ([<tt>ec9d9e5</tt>](https://github.com/yuki24/rambulance/commit/ec9d9e5de98eeec501042a0bbb95ae8ac8d7b4e3))

## [v1.0.1](https://github.com/yuki24/rambulance/tree/v1.0.1)

_<sup>released at 2019-06-04 16:30:38 UTC</sup>_

#### Fixes

- Fixes an issue where `ExceptionsApp` prevents Rails from booting up ([#49](https://github.com/yuki24/rambulance/issues/49))

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
- Add a test helper method `#with_exceptions_app ` for easier testing ([<tt>f5c16b9</tt>](https://github.com/yuki24/rambulance/commit/f5c16b90ecf5eb4903faa30d760bf5863441e9c5), [#27](https://github.com/yuki24/rambulance/pull/27), [@kbaba1001](https://github.com/kbaba1001))

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
- Drop support for Haml and Slim templates

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
