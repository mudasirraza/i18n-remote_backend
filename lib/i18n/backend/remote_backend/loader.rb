# frozen_string_literal: true

require 'open-uri'

module I18n
  module Backend
    class RemoteBackend
      class Loader
        attr_reader :locale
        attr_accessor :yaml

        def initialize(locale = default_locale)
          @locale = locale
        end

        def fetch_locale
          raise RemoteBackend::BlankURLException if RemoteBackend.configuration.http_url.nil?

          begin
            yaml = YAML.safe_load(fetch_remote_file)
            Utils.deep_symbolize_keys(yaml) if yaml.instance_of?(Hash)
          rescue StandardError => e
            RemoteBackend.logger.error "Error occured while reading remote locale : #{RemoteBackend.configuration.http_url}/#{locale} error: " + e.inspect
            nil
          end
        end

        private

        def fetch_remote_file
          URI.parse("#{RemoteBackend.configuration.http_url}/#{@locale}").open.read
        end
      end
    end
  end
end
