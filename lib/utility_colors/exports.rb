# frozen_string_literal: true

module UtilityColors
  class Exports
    def self.json(filename, output_classes)
      # TODO: determine if they imported scss or css and return the variables keys in that way
      # TODO: determine if the style value should use a syntax variable or be converted to hardcoded value
      content = JSON.pretty_generate(output_classes.transform_values { |class_content| class_content.gsub('£$', '$').gsub('$£', '') })
      filepath = "#{filename}.json"

      # Create directory if it doesn't exist
      FileUtils.mkdir_p(File.dirname(filepath))
      File.write(filepath, content)

      puts 'Exporting utility colour classes JSON...'
      true
    end

    def self.scss(filename, output_classes)
      # TODO: determine if the style value should use the syntax variable or be converted to hardcoded value
      content = output_classes.collect { |class_name, class_content| "#{class_name} {\n\t#{class_content.gsub('£$', '$').gsub('$£', '')}\n}" }.join("\n\n")
      filepath = "#{filename}.scss"

      # Create directory if it doesn't exist
      FileUtils.mkdir_p(File.dirname(filepath))
      File.write(filepath, content)

      puts 'Exporting utility colour classes SCSS...'
      true
    end

    def self.css(filename, output_classes)
      # TODO: add root for variables at top? Leave for now as this is all based off a palette file where they should exist (easy copy and paste for devs)
      # TODO: determine if the style value should use the syntax variable or be converted to hardcoded value
      content = output_classes.collect { |class_name, class_content| "#{class_name} {\n\t#{class_content.gsub('£$', 'var(--').gsub('$£', ')')}\n}" }.join("\n\n")
      filepath = "#{filename}.css"

      # Create directory if it doesn't exist
      FileUtils.mkdir_p(File.dirname(filepath))
      File.write(filepath, content)

      puts 'Exporting utility colour classes CSS...'
      true
    end

    def bespoke_property_variables
      # const utilities = {
      #   bg: (value) => ({ 'background-color': value }),
      #   text: (value) => ({ 'color': value }),
      #   border: (value) => ({ 'border-color': value }),
      #   'border-t': (value) => ({ '--tw-border-opacity': 1, 'border-top-color': value }),
      #   'border-r': (value) => ({ '--tw-border-opacity': 1, 'border-right-color': value }),
      #   'border-b': (value) => ({ '--tw-border-opacity': 1, 'border-bottom-color': value }),
      #   'border-l': (value) => ({ '--tw-border-opacity': 1, 'border-left-color': value }),
      #   outline: (value) => ({ 'outline-color': value }),
      #   ring: (value) => ({ '--tw-ring-opacity': 1, '--tw-ring-color': value }),
      #   'ring-offset': (value) => ({ '--tw-ring-offset-color': value }),
      #   'shadow': (value) => ({ '--tw-shadow-color': value, '--tw-shadow': 'var(--tw-shadow-colored)' }),
      #   accent: (value) => ({ 'accent-color': value }),
      #   caret: (value) => ({ 'caret-color': value }),
      #   fill: (value) => ({ 'fill': value }),
      #   stroke: (value) => ({ 'stroke': value }),
      # };
    end

    def self.append_percentage(value)
      "#{value}%"
    end

    def self.append_alpha(alpha)
      "/ #{alpha * 100}"
    end
  end
end
