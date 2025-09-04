# frozen_string_literal: true

module UtilityColors
  class Imports
    def self.import
      import_path = UtilityColors.configuration.import_palettes_filepath

      if import_path.present? && File.file?(import_path)
        case File.extname(import_path)
        when '.json'
          UtilityColors::Imports.json(import_path)
        when '.scss'
          UtilityColors::Imports.scss(import_path)
        when '.css'
          UtilityColors::Imports.css(import_path)
        else
          warn 'WARNING: Palette file could not be imported as it is not JSON, SCSS, or CSS.'
          {}
        end
      else
        {}
      end
    end

    private

    def self.json(import_path)
      # expecting a normal json hash of name and value
      JSON.parse(File.read(import_path))
    end

    def self.scss(import_path)
      # expecting a normal scss file of variables
      File.read(import_path).scan(/\$([^:]+):\s*([^;]+);/).to_h
    end

    def self.css(import_path)
      # expecting a normal css file of variables
      File.read(import_path).scan(/--([^:]+):\s*([^;]+);/).to_h
    end
  end
end
