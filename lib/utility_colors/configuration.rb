# frozen_string_literal: true

module UtilityColors
  class Configuration
    attr_accessor :enable_environments,
                  :import_palettes_filepath,
                  :output_filename, :output_dated, :output_files, :output_prefix, :output_suffix,
                  :regular_classes, :breakpoint_classes, :pseudo_classes, :breakpoint_pseudo_classes # :utility_palettes_configuration

    def initialize
      # Enabled Environments
      @enable_environments = [:development]

      # Use Existing Utility Palettes Result
      @import_palettes_filepath = nil

      # Output
      @output_filename = 'utility_colors'
      @output_dated = false
      @output_files = ['scss']
      @output_prefix = nil
      @output_suffix = nil

      # Build Other Class Types
      @regular_classes = true
      @breakpoint_classes = false
      @pseudo_classes = false
      @breakpoint_pseudo_classes = false

      # Configuration instance for UtilityPalettes
      # @utility_palettes_configuration = UtilityPalettes::Configuration.new
    end

    def reset!
      initialize
    end

    # Nested configuration method for UtilityPalettes
    def configure_utility_palettes
      # yield(@utility_palettes_configuration) if block_given?
    end

    def validate_settings
      # Validate UtilityPalettes configuration
      # return false unless @utility_palettes_configuration.validate_settings

      # Add any additional validations specific to UtilityColors
      true
    end
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end
