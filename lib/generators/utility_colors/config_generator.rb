# frozen_string_literal: true

begin
  require 'rails/generators'
  require 'rails/generators/base'
rescue LoadError => e
  raise LoadError, "railties gem is required for generators. Add 'railties' to your Gemfile: #{e.message}"
end

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
