# frozen_string_literal => true

module UtilityColors
  class Properties
    def self.get_property(*diggers)
      diggers = [diggers] unless diggers.is_a?(Array)

      property = UtilityColors::Properties.send(diggers[0])
      property = property.dig(*diggers.slice(1..-1)) if diggers.length > 1

      property
    end

    def self.screen_sizes
      {
        'sm' => '325px',
        'md' => '768px',
        'lg' => '1024px',
        'xl' => '1440px'
      }
    end

    def self.pseudo_input
      [
        'checked',
        'disabled',
        'enabled',
        'focus'
      ]
    end

    def self.pseudo_input_extra
      [
        'in-range',
        'invalid',
        'optional',
        'out-of-range',
        'read-only',
        'read-write',
        'require',
        'valid'
      ]
    end

    def self.pseudo_action
      [
        'active',
        'hover',
        'link',
        'target',
        'visited'
      ]
    end

    def self.pseudo_child
      [
        'root',
        'first-child',
        'first-of-type',
        'last-child',
        'last-of-type',
        'only-of-type',
        'only-child',
        'empty'
        # // nth-child(n},
        # // nth-last-child(n},
        # // nth-last-of-type(n},
        # // nth-of-type(n},
      ]
    end

    def self.pseudos
      UtilityColors::Properties.pseudo_input + UtilityColors::Properties.pseudo_action + UtilityColors::Properties.pseudo_child
    end
  end
end
