# frozen_string_literal: true

module UtilityColors
  class Colors
    def self.generate
      configuration = UtilityColors.configuration

      generated_regular_classes = {}
      generated_breakpoint_classes = {}
      generated_pseudo_classes = {}
      generated_pseudo_breakpoint_classes = {}

      puts 'Generating utility colour classes...'

      colour_palette = UtilityColors::Imports.import

      puts 'Retrieved colour palettes...'

      generated_source_classes = UtilityColors::Colors.build_source_classes(colour_palette)

      puts 'Generated source colour classes...'

      if configuration.regular_classes
        generated_regular_classes = generated_source_classes
        puts 'Generated regular colour classes...'
      end

      if configuration.breakpoint_classes
        generated_breakpoint_classes = UtilityColors::Builders.bulk_breakpoint_class_creation(generated_source_classes)
        puts 'Generated breakpoint colour classes...'
      end

      if configuration.breakpoint_classes
        generated_pseudo_classes = UtilityColors::Builders.bulk_pseudo_class_creation(generated_source_classes)
        puts 'Generated breakpoint colour classes...'
      end

      if configuration.breakpoint_classes
        generated_pseudo_breakpoint_classes = UtilityColors::Builders.bulk_pseudo_breakpoint_class_creation(generated_source_classes)
        puts 'Generated breakpoint colour classes...'
      end

      generated_classes = {}.merge(generated_regular_classes, generated_breakpoint_classes, generated_pseudo_classes, generated_pseudo_breakpoint_classes)
      formatted_classes = self.format_classes(generated_classes)

      filename = configuration.output_filename
      filename += "-#{Time.zone.now.strftime('%Y%m%d-%H%M%S')}" if configuration.output_dated == true

      output_files = configuration.output_files.map(&:strip)

      UtilityColors::Exports.json(filename, formatted_classes) if output_files.include?('json')
      UtilityColors::Exports.scss(filename, formatted_classes) if output_files.include?('scss')
      UtilityColors::Exports.css(filename, formatted_classes) if output_files.include?('css')

      true
    end

    private

    def self.build_source_classes(colour_palette)
      colour_style_prefix_and_property = {
        'color' => 'color',
        'bg' => 'background-color',
        'accent-c' => 'accent-color',
        'border-c' => 'border-color',
        'outline-c' => 'outline-color',
        'decoration-c' => 'text-decoration-color',
        'caret-c' => 'caret-color',
        'svg-fill-c' => 'fill',
        'svg-stroke-c' => 'stroke'
      }

      # 'box-shadow' => '--uc-box-shadow-c'
      # 'drop-shadow' => '--uc-drop-shadow-c'

      current_colour_class = colour_style_prefix_and_property.collect do |style_class_type, style_property|
        UtilityColors::Builders.utility_classes_creation("#{style_class_type}--current", [style_property, 'currentColor'])
      end.reduce({}, :merge)

      # initially use the palette key as the style value so that it can be more easily replaced for the correct type of variable when it is exported
      base_colour_classes = colour_palette.keys.collect do |style_modifier|
        colour_style_prefix_and_property.collect do |style_class_type, style_property|
          UtilityColors::Builders.utility_classes_creation("#{style_class_type}--#{style_modifier}", [style_property, "£$#{style_modifier}$£"])
        end
      end.flatten.reduce({}, :merge)

      {}.merge!(current_colour_class, base_colour_classes)
    end

    def self.format_classes(generated_hash)
      configuration = UtilityColors.configuration

      generated_hash.transform_keys!(&:to_s)
      generated_hash.transform_keys! { |key| configuration.output_prefix + key } if configuration.output_prefix.present?
      generated_hash.transform_keys! { |key| key + configuration.output_suffix } if configuration.output_suffix.present?

      generated_hash.transform_keys! { |key| ".#{key}" }

      generated_hash
    end
  end
end
