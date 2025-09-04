# frozen_string_literal: true

module UtilityColors
  class Builders
    # '.' are appended during final formatting

    # 'color--red-400'
    def self.utility_classes_creation(class_name, content)
      content = [content] unless content.is_a?(Array)
      { class_name => "#{content.join(': ')};" }
    end

    # ';' are already in the content from the above source method
    # 'md|color--red-400'
    def self.utility_pseudo_classes_creation(class_name, content, pseudo)
      content = [content] unless content.is_a?(Array)
      { "#{pseudo}\\|#{class_name}:#{pseudo}" => content.join(': ') }
    end

    # 'hover|color--red-400'
    def self.utility_breakpoint_classes_creation(class_name, content, initial, screen_size)
      content = [content] unless content.is_a?(Array)
      { "#{initial}\\|#{class_name}" => "@media only screen and (min-width: #{screen_size - 1}) { #{content.join(': ')} }" }
    end

    # 'hover|md|color--red-400'
    def self.utility_pseudo_breakpoint_classes_creation(class_name, content, pseudo, initial, screen_size)
      content = [content] unless content.is_a?(Array)
      { "#{pseudo}\\|#{initial}\\|#{class_name}:#{pseudo}" => "@media only screen and (min-width: #{screen_size - 1}) { #{content.join(': ')} }" }
    end

    # Bulk Methods

    def self.utility_classes(class_name, content)
      UtilityColors::Builders.utility_classes_creation(class_name, content)
    end

    def self.bulk_breakpoint_class_creation(class_hash)
      uc_screens = UtilityColors::Properties.screen_sizes.transform_values(&:to_f)

      uc_screens.collect do |initial, screen_size|
        class_hash.collect do |class_name, content|
          UtilityColors::Builders.utility_breakpoint_classes_creation(class_name, content, initial, screen_size)
        end
      end.flatten.reduce({}, :merge)
    end

    def self.bulk_pseudo_class_creation(class_hash)
      uc_pseudos = UtilityColors::Properties.pseudos

      uc_pseudos.collect do |pseudo|
        class_hash.collect do |class_name, content|
          UtilityColors::Builders.utility_pseudo_classes_creation(class_name, content, pseudo)
        end
      end.flatten.reduce({}, :merge)
    end

    def self.bulk_pseudo_breakpoint_class_creation(class_hash)
      uc_screens = UtilityColors::Properties.screen_sizes.transform_values(&:to_f)
      uc_pseudos = UtilityColors::Properties.pseudos

      uc_screens.collect do |initial, screen_size|
        uc_pseudos.collect do |pseudo|
          class_hash.collect do |class_name, content|
            UtilityColors::Builders.utility_pseudo_breakpoint_classes_creation(class_name, content, pseudo, initial, screen_size)
          end
        end
      end.flatten.flatten.reduce({}, :merge)
    end

    # * Advanced Classes

    # utility_classes(class)
    # .class { content }
  end
end
