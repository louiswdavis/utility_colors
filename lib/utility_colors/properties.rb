# frozen_string_literal: true

module UtilityColors
  class Properties
    def self.get_property(*keys)
      keys = [keys] unless keys.is_a?(Array)

      property = UtilityColors::Properties.send(keys[0])
      property = property.dig(*keys.slice(1..-1)) if keys.length > 1

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

    # TODO: add it in
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
