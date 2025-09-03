# frozen_string_literal: true

module UtilityColors
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path('../../..', __dir__)

      def copy_config
        copy_file 'lib/generators/templates/config/utility_colors.rb', 'config/initializers/utility_colors.rb'
      end
    end
  end
end
