# frozen_string_literal: true

module UtilityColors
  module Generators
    class GenerateGenerator < Rails::Generators::Base
      def generate_utility_colors
        # TODO: check if the v0.1.8 scss files exists
        # "app/app/assets/stylesheets/utility_colors_files" directory
        self.class.config_format_warn if File.exist?('config/utility_colors.yml') || File.exist?('config/utility_colors.json')

        if UtilityColors.configuration.enable_environments.include?(Rails.env.to_sym)
          UtilityColors::Colors.generate
        else
          self.class.disabled_warn
        end
      end

      private

      # TODO: add links to README for migration
      def self.config_format_warn
        warn 'WARNING: Utility Colors now uses an initializer to set config. You need to migrate and remove your YML/JSON file.'
      end

      # TODO: add links to README for environment setting
      def self.disabled_warn
        warn 'ERROR: Utility Colors is disabled for this environment. Color classes will not be generated.'
      end
    end
  end
end
