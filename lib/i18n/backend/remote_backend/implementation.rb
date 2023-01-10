# frozen_string_literal: true

require 'i18n/backend/base'

module I18n
  module Backend
    class RemoteBackend
      module Implementation
        include Base

        attr_accessor :store

        def initialize
          @store = {}
          I18n.enforce_available_locales = false
        end

        def initialized?
          !@store.nil?
        end

        def store_translations(locale, data, _options = {})
          @store[locale] = data
        end

        def available_locales
          @store.keys.map(&:to_sym)
        end

        def translations
          @store
        end

        def init_translations
          @store
        end

        protected

        def lookup(locale, key, scope = [], options = {})
          return unless fetch_remote_translations(locale)

          keys = I18n.normalize_keys(locale, key, scope, options[:separator])
          keys.inject(translations) do |result, k|
            return nil unless result.is_a?(Hash)

            unless result.key?(k)
              k = k.to_s.to_sym
              return nil unless result.key?(k)
            end
            result[k]
          end
        end

        def fetch_remote_translations(locale)
          return @store[locale] if @store[locale]

          data = Loader.new(locale).fetch_locale
          @store[locale] = data[locale] if data

          @store[locale]
        end
      end
    end
  end
end
