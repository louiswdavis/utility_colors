# frozen_string_literal: true

RSpec.describe UtilityColors::Configuration do
  context 'attributes' do
    it 'tests all declared attribute accessors' do
      # You can manually list what you expect to be there
      expected_accessors = [
        :enable_environments,
        :import_palettes_filepath,
        :output_filename, :output_dated, :output_files, :output_prefix, :output_suffix,
        :regular_classes, :breakpoint_classes, :pseudo_classes, :breakpoint_pseudo_classes
      ]

      expected_defaults = [[:development], 'utility_palettes.scss', 'utility_colors', false, ['scss'], nil, nil, true, false, false, false]

      configuration_class = UtilityColors::Configuration.new
      configuration = described_class.new

      actual_accessors = configuration_class.methods.reject { |m| m.to_s.end_with?('=') }.reject { |m| m.to_s.start_with?('_') }.reject { |m| m.to_s.start_with?('!') }.select { |m| configuration_class.respond_to?("#{m}=") }

      expect(actual_accessors.length).to eq 11
      expect(expected_accessors.length).to eq 11
      expect(actual_accessors).to match_array expected_accessors

      expected_accessors.each_with_index do |accessor, index|
        expect(configuration_class).to respond_to(accessor)
        expect(configuration_class).to respond_to("#{accessor}=")

        expect(configuration.send(accessor)).to eq expected_defaults[index]
      end
    end

    it '.setters' do
      configuration = described_class.new
      configuration.enable_environments = [:something]
      expect(configuration.enable_environments).to eq([:something])
    end
  end

  context 'methods' do
    it '.responds_to' do
      expect(described_class.new).to respond_to(:reset!)
      expect(described_class.new).to respond_to(:validate_settings)

      expect(UtilityColors).to respond_to(:configuration)
      expect(UtilityColors).to respond_to(:reset_configuration!)
    end

    it '.reset!' do
      configuration = described_class.new
      configuration.enable_environments = [:something]

      configuration.reset!
      expect(configuration.enable_environments).to eq([:development])
    end

    it '.validate_settings' do
    end
  end

  context 'usage' do
    it 'returns a Configuration instance' do
      expect(UtilityColors.configuration).to be_a(UtilityColors::Configuration)
    end

    it 'returns the same instance on multiple calls' do
      config1 = UtilityColors.configuration
      config2 = UtilityColors.configuration
      expect(config1).to be(config2)
    end

    it '.reset_configuration! on the Configuration instance' do
      configuration = UtilityColors.configuration

      configuration.enable_environments = [:something]
      expect(configuration.enable_environments).to eq([:something])

      UtilityColors.reset_configuration!

      # Get the NEW configuration instance after reset
      new_configuration = UtilityColors.configuration
      expect(new_configuration.enable_environments).to eq([:development])

      # Optional: also test that it's actually a different instance
      expect(new_configuration).not_to be(configuration)
    end
  end
end
