# frozen_string_literal: true

require 'uri'

module I18n
  module Backend
    class RemoteBackend
      class Configuration
        attr_reader :http_url

        def http_url=(http_url)
          raise RemoteBackend::InvalidURLException unless http_url =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]

          @http_url = http_url
        end
      end
    end
  end
end
