# frozen_string_literal: true

require 'logger'
Dir["#{File.dirname(__FILE__)}/remote_backend/*.rb"].sort.each { |file| require file }

module I18n
  module Backend
    class RemoteBackend
      include Implementation

      class << self
        def configuration
          @configuration ||= Configuration.new
        end

        def configure
          yield(configuration) if block_given?
        end

        def logger
          @logger ||= defined?(Rails) ? Rails.logger : Logger.new($stdout)
        end
      end
    end
  end
end
