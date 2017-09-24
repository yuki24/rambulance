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
