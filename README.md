# I18n::RemoteBackend

I18n backend for loading remote locales via HTTP.

## Installation

Put the following in your Gemfile:

```ruby
gem 'i18n-remote_backend'
```

After updating your bundle, run the installer

    $ rails g i18n:remote_backend:install

It generates a new file in `config/initializers` named `i18n_remote_backend.rb` with the following content.

```ruby
require 'i18n/backend/remote_backend'

I18n.backend = I18n::Backend::Chain.new(I18n::Backend::RemoteBackend.new, I18n::Backend::Simple.new)

I18n::Backend::RemoteBackend.configure do |config|
  # config.http_url = ''
end
```

Set the http_url accordingly. e.g `https://example-url/locales`
The corresponding generated requests will look like: `https://example-url/locales/en` or `https://example-url/locales/fr` etc.
And it should respond back with the yaml file content.

If a remote translation is unavailable, it will fall back to a local translation.

## Usage

You can then use `I18n.t('text')`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mudasirraza/i18n-remote_backend.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
