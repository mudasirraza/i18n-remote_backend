# frozen_string_literal: true

require 'i18n/backend/remote_backend'

I18n.backend = I18n::Backend::Chain.new(I18n::Backend::RemoteBackend.new, I18n::Backend::Simple.new)

I18n::Backend::RemoteBackend.configure do |config|
  # config.http_url = ''
end
