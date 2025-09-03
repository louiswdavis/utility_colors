# frozen_string_literal: true

require 'json'

RSpec.describe UtilityColors::Exports do
  context 'methods' do
    it '.responds_to' do
      expect(described_class).to respond_to(:json)
      expect(described_class).to respond_to(:scss)
      expect(described_class).to respond_to(:css)
    end

    before do
      @formatted_classes = {
        '.sm|color--current' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
        '.md|color--current' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
        '.lg|color--current' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
        '.xl|color--current' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
        'color--colour-300' => 'color: £$colour-300$£;',
        'bg--colour-300' => 'background-color: £$colour-300$£;'
      }
    end

    it '.json' do
      filepath = 'spec/tmp/exports/dummy'
      result = described_class.json(filepath, @formatted_classes)

      expect(result).to eq true
      expect(File.exist?("#{filepath}.json")).to be true
      file_content = JSON.parse(File.read("#{filepath}.json"))

      expect(file_content.length).to eq 6
      expect(file_content).to eq(
        {
          '.sm|color--current' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          '.md|color--current' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          '.lg|color--current' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          '.xl|color--current' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'color--colour-300' => 'color: $colour-300;',
          'bg--colour-300' => 'background-color: $colour-300;'
        }
      )
    end

    it '.scss' do
      filepath = 'spec/tmp/exports/dummy'
      result = described_class.scss(filepath, @formatted_classes)

      expect(result).to eq true
      expect(File.exist?("#{filepath}.scss")).to be true

      file_content = File.read("#{filepath}.scss").gsub("\t", '  ').split("\n\n")

      expect(file_content.length).to eq 6
      expect(file_content).to eq(
        [
          ".sm|color--current {\n  @media only screen and (min-width: 324.0) { color: currentColor; }\n}",
          ".md|color--current {\n  @media only screen and (min-width: 767.0) { color: currentColor; }\n}",
          ".lg|color--current {\n  @media only screen and (min-width: 1023.0) { color: currentColor; }\n}",
          ".xl|color--current {\n  @media only screen and (min-width: 1439.0) { color: currentColor; }\n}",
          "color--colour-300 {\n  color: $colour-300;\n}",
          "bg--colour-300 {\n  background-color: $colour-300;\n}"
        ]
      )
    end

    it '.css' do
      filepath = 'spec/tmp/exports/dummy'
      result = described_class.css(filepath, @formatted_classes)

      expect(result).to eq true
      expect(File.exist?("#{filepath}.css")).to be true
      file_content = File.read("#{filepath}.css").gsub("\t", '  ').split("\n\n")

      expect(file_content.length).to eq 6
      expect(file_content).to eq(
        [
          ".sm|color--current {\n  @media only screen and (min-width: 324.0) { color: currentColor; }\n}",
          ".md|color--current {\n  @media only screen and (min-width: 767.0) { color: currentColor; }\n}",
          ".lg|color--current {\n  @media only screen and (min-width: 1023.0) { color: currentColor; }\n}",
          ".xl|color--current {\n  @media only screen and (min-width: 1439.0) { color: currentColor; }\n}",
          "color--colour-300 {\n  color: var(--colour-300);\n}",
          "bg--colour-300 {\n  background-color: var(--colour-300);\n}"
        ]
      )
    end
  end

  context 'private methods' do
    it '.responds_to' do
      expect(described_class).to respond_to(:append_percentage)
      expect(described_class).to respond_to(:append_alpha)
    end

    it '.append_percentage' do
      expect(described_class.append_percentage(0.0)).to eq '0.0%'
      expect(described_class.append_percentage(17.5)).to eq '17.5%'
      expect(described_class.append_percentage(100.0)).to eq '100.0%'
    end

    it '.append_alpha' do
      expect(described_class.append_alpha(0.0)).to eq '/ 0.0'
      expect(described_class.append_alpha(0.17)).to eq '/ 17.0'
      expect(described_class.append_alpha(1.0)).to eq '/ 100.0'
    end
  end
end
