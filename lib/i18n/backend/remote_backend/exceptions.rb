# frozen_string_literal: true

module I18n
  module Backend
    class RemoteBackend
      class InvalidURLException < StandardError; end
      class BlankURLException < StandardError; end
    end
  end
end
