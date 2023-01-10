# frozen_string_literal: true

require_relative 'lib/i18n/remote_backend/version'

Gem::Specification.new do |spec|
  spec.name = 'i18n-remote_backend'
  spec.version = I18n::RemoteBackend::VERSION
  spec.authors = ['Mudasir Raza']
  spec.email = ['i18n-remote@googlegroups.com']

  spec.summary = 'Adds support for fetching translation from a remote resource'
  spec.homepage = "https://github.com/mudasirraza/i18n-remote_backend"
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mudasirraza/i18n-remote_backend"
  spec.metadata["changelog_uri"] = "https://github.com/mudasirraza/i18n-remote_backend/blob/main/CHANGELOG.md"

  spec.files = Dir.glob('{lib,test}/**/**') + %w[LICENSE.txt README.md Rakefile]
  spec.platform = Gem::Platform::RUBY
  spec.require_paths = ['lib']

  spec.add_dependency 'i18n', '~> 1.12'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
