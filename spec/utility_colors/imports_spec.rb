# frozen_string_literal: true

require 'json'

RSpec.describe UtilityColors::Imports do
  context 'methods' do
    it '.responds_to' do
      expect(described_class).to respond_to(:import)
    end

    it '.import' do
      configuration = UtilityColors.configuration

      expect(described_class.import).to eq({})

      configuration.import_palettes_filepath = 'spec/fixtures/imports/palette.json'
      expect(described_class.import).to eq({ 'colour-300' => '#938312', 'colour-500' => 'rgb(51, 102, 204)' })

      configuration.import_palettes_filepath = 'spec/fixtures/imports/palette.scss'
      expect(described_class.import).to eq({ 'colour-100' => 'hsl(50, 25, 75)', 'colour-50' => '#123456' })

      configuration.import_palettes_filepath = 'spec/fixtures/imports/palette.css'
      expect(described_class.import).to eq({ 'colour-100' => 'hsla(23, 46, 71, 12)', 'colour-50' => '#123456' })

      configuration.import_palettes_filepath = 'spec/fixtures/utility_colors.rb'
      expect(described_class.import).to eq({})
    end
  end

  context 'private methods' do
    it '.responds_to' do
      expect(described_class).to respond_to(:json)
      expect(described_class).to respond_to(:scss)
      expect(described_class).to respond_to(:css)
    end

    it '.json' do
      import_path = 'spec/fixtures/imports/palette.json'
      result = described_class.json(import_path)

      expect(result.length).to eq 2
      expect(result).to eq({ 'colour-300' => '#938312', 'colour-500' => 'rgb(51, 102, 204)' })
    end

    it '.scss' do
      import_path = 'spec/fixtures/imports/palette.scss'
      result = described_class.scss(import_path)

      expect(result.length).to eq 2
      expect(result).to eq({ 'colour-100' => 'hsl(50, 25, 75)', 'colour-50' => '#123456' })
    end

    it '.css' do
      import_path = 'spec/fixtures/imports/palette.css'
      result = described_class.css(import_path)

      expect(result.length).to eq 2
      expect(result).to eq({ 'colour-100' => 'hsla(23, 46, 71, 12)', 'colour-50' => '#123456' })
    end
  end
end
