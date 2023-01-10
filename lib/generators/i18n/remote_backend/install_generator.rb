# frozen_string_literal: true

module I18n
  module RemoteBackend
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'This generator creates an initializer file at config/initializers'

        source_root File.expand_path('templates', __dir__)

        def copy_initializer
          template 'initializer.rb', 'config/initializers/i18n_remote_backend.rb'
        end
      end
    end
  end
end
