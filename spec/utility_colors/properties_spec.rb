# frozen_string_literal: true

RSpec.describe UtilityColors::Properties do
  context 'methods' do
    it '.responds_to' do
      expect(described_class).to respond_to(:get_property)

      expect(described_class).to respond_to(:screen_sizes)
      expect(described_class).to respond_to(:pseudo_input)
      expect(described_class).to respond_to(:pseudo_input_extra)
      expect(described_class).to respond_to(:pseudo_action)
      expect(described_class).to respond_to(:pseudo_child)
      expect(described_class).to respond_to(:pseudos)
    end

    it '.get_property' do
      expect(described_class.get_property(:screen_sizes)).to eq({ 'lg' => '1024px', 'md' => '768px', 'sm' => '325px', 'xl' => '1440px' })
      expect(described_class.get_property('screen_sizes')).to eq({ 'lg' => '1024px', 'md' => '768px', 'sm' => '325px', 'xl' => '1440px' })

      expect(described_class.get_property(:screen_sizes, 'md')).to eq '768px'
      expect(described_class.get_property(:screen_sizes, :md)).to eq nil

      # TODO: test with second layer once their is a method with them
    end

    it 'others' do
      expect(described_class.screen_sizes.length).to eq 4
      expect(described_class.pseudo_input.length).to eq 4
      expect(described_class.pseudo_input_extra.length).to eq 8
      expect(described_class.pseudo_action.length).to eq 5
      expect(described_class.pseudo_child.length).to eq 8
      expect(described_class.pseudos.length).to eq 17
    end
  end
end
