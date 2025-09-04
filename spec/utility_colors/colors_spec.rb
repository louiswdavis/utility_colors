# frozen_string_literal: true

RSpec.describe UtilityColors::Colors do
  context 'methods' do
    it '.responds_to' do
      expect(described_class).to respond_to(:generate)
    end

    it '.generate' do
      configuration = UtilityColors.configuration
      configuration.import_palettes_filepath = 'spec/fixtures/imports/palette.json'
      configuration.output_filename = 'spec/tmp/exports/palette'
      configuration.breakpoint_classes = true
      configuration.pseudo_classes = true
      configuration.breakpoint_pseudo_classes = true

      allow(UtilityColors).to receive(:configuration).and_call_original

      allow(UtilityColors::Imports).to receive(:import).and_call_original
      allow(UtilityColors::Imports).to receive(:json).and_call_original
      allow(UtilityColors::Imports).to receive(:scss).and_call_original
      allow(UtilityColors::Imports).to receive(:css).and_call_original

      allow(UtilityColors::Builders).to receive(:bulk_breakpoint_class_creation).and_call_original
      allow(UtilityColors::Builders).to receive(:bulk_pseudo_class_creation).and_call_original
      allow(UtilityColors::Builders).to receive(:bulk_pseudo_breakpoint_class_creation).and_call_original

      allow(UtilityColors::Builders).to receive(:utility_classes_creation).and_call_original
      allow(UtilityColors::Builders).to receive(:utility_pseudo_classes_creation).and_call_original
      allow(UtilityColors::Builders).to receive(:utility_breakpoint_classes_creation).and_call_original
      allow(UtilityColors::Builders).to receive(:utility_pseudo_breakpoint_classes_creation).and_call_original

      allow(UtilityColors::Colors).to receive(:format_classes).and_call_original

      allow(UtilityColors::Exports).to receive(:json).and_call_original
      allow(UtilityColors::Exports).to receive(:scss).and_call_original
      allow(UtilityColors::Exports).to receive(:css).and_call_original

      expect(described_class.generate).to eq true

      expect(UtilityColors).to have_received(:configuration).exactly(3).times

      expect(UtilityColors::Imports).to have_received(:import).exactly(1).times
      expect(UtilityColors::Imports).to have_received(:json).exactly(1).times
      expect(UtilityColors::Imports).to have_received(:scss).exactly(0).times
      expect(UtilityColors::Imports).to have_received(:css).exactly(0).times

      expect(UtilityColors::Builders).to have_received(:bulk_breakpoint_class_creation).exactly(1).times
      expect(UtilityColors::Builders).to have_received(:bulk_pseudo_class_creation).exactly(1).times
      expect(UtilityColors::Builders).to have_received(:bulk_pseudo_breakpoint_class_creation).exactly(1).times

      expect(UtilityColors::Builders).to have_received(:utility_classes_creation).exactly(27).times
      expect(UtilityColors::Builders).to have_received(:utility_pseudo_classes_creation).exactly(459).times
      expect(UtilityColors::Builders).to have_received(:utility_breakpoint_classes_creation).exactly(108).times
      expect(UtilityColors::Builders).to have_received(:utility_pseudo_breakpoint_classes_creation).exactly(1836).times

      expect(UtilityColors::Colors).to have_received(:format_classes).exactly(1).times

      expect(UtilityColors::Exports).to have_received(:json).exactly(0).times
      expect(UtilityColors::Exports).to have_received(:scss).exactly(1).times
      expect(UtilityColors::Exports).to have_received(:css).exactly(0).times
    end
  end

  context 'private methods' do
    it '.responds_to' do
      expect(described_class).to respond_to(:build_source_classes)
      expect(described_class).to respond_to(:format_classes)
    end

    before do
      @colour_palette = { 'colour-300' => '#938312', 'colour-500' => 'rgb(51, 102, 204)' }

      @generated_hash = {
        'sm|color--current' => '@media only screen and (min-width: 324.0) { color: currentColor }',
        'md|color--current' => '@media only screen and (min-width: 767.0) { color: currentColor }',
        'lg|color--current' => '@media only screen and (min-width: 1023.0) { color: currentColor }',
        'xl|color--current' => '@media only screen and (min-width: 1439.0) { color: currentColor }'
      }
    end

    it '.build_source_classes' do
      expect(described_class.build_source_classes({})).to eq(
        {
          'color--current' => 'color: currentColor;',
          'bg--current' => 'background-color: currentColor;',
          'accent-c--current' => 'accent-color: currentColor;',
          'border-c--current' => 'border-color: currentColor;',
          'outline-c--current' => 'outline-color: currentColor;',
          'decoration-c--current' => 'text-decoration-color: currentColor;',
          'caret-c--current' => 'caret-color: currentColor;',
          'svg-fill-c--current' => 'fill: currentColor;',
          'svg-stroke-c--current' => 'stroke: currentColor;'
        }
      )
      expect(described_class.build_source_classes(@colour_palette)).to eq(
        {
          'color--current' => 'color: currentColor;',
          'bg--current' => 'background-color: currentColor;',
          'accent-c--current' => 'accent-color: currentColor;',
          'border-c--current' => 'border-color: currentColor;',
          'outline-c--current' => 'outline-color: currentColor;',
          'decoration-c--current' => 'text-decoration-color: currentColor;',
          'caret-c--current' => 'caret-color: currentColor;',
          'svg-fill-c--current' => 'fill: currentColor;',
          'svg-stroke-c--current' => 'stroke: currentColor;',
          'color--colour-300' => 'color: £$colour-300$£;',
          'bg--colour-300' => 'background-color: £$colour-300$£;',
          'accent-c--colour-300' => 'accent-color: £$colour-300$£;',
          'border-c--colour-300' => 'border-color: £$colour-300$£;',
          'outline-c--colour-300' => 'outline-color: £$colour-300$£;',
          'decoration-c--colour-300' => 'text-decoration-color: £$colour-300$£;',
          'caret-c--colour-300' => 'caret-color: £$colour-300$£;',
          'svg-fill-c--colour-300' => 'fill: £$colour-300$£;',
          'svg-stroke-c--colour-300' => 'stroke: £$colour-300$£;',
          'color--colour-500' => 'color: £$colour-500$£;',
          'bg--colour-500' => 'background-color: £$colour-500$£;',
          'accent-c--colour-500' => 'accent-color: £$colour-500$£;',
          'border-c--colour-500' => 'border-color: £$colour-500$£;',
          'outline-c--colour-500' => 'outline-color: £$colour-500$£;',
          'decoration-c--colour-500' => 'text-decoration-color: £$colour-500$£;',
          'caret-c--colour-500' => 'caret-color: £$colour-500$£;',
          'svg-fill-c--colour-500' => 'fill: £$colour-500$£;',
          'svg-stroke-c--colour-500' => 'stroke: £$colour-500$£;'
        }
      )
    end

    it '.format_classes' do
      configuration = UtilityColors.configuration

      generated_hash = @generated_hash.dup # create a copy rather than just another assignment
      expect(described_class.format_classes(generated_hash)).to eq(
        {
          '.sm|color--current' => '@media only screen and (min-width: 324.0) { color: currentColor }',
          '.md|color--current' => '@media only screen and (min-width: 767.0) { color: currentColor }',
          '.lg|color--current' => '@media only screen and (min-width: 1023.0) { color: currentColor }',
          '.xl|color--current' => '@media only screen and (min-width: 1439.0) { color: currentColor }'
        }
      )

      # prefix
      configuration.output_prefix = 'basic-'

      generated_hash = @generated_hash.dup # create a copy rather than just another assignment
      expect(described_class.format_classes(generated_hash)).to eq(
        {
          '.basic-sm|color--current' => '@media only screen and (min-width: 324.0) { color: currentColor }',
          '.basic-md|color--current' => '@media only screen and (min-width: 767.0) { color: currentColor }',
          '.basic-lg|color--current' => '@media only screen and (min-width: 1023.0) { color: currentColor }',
          '.basic-xl|color--current' => '@media only screen and (min-width: 1439.0) { color: currentColor }'
        }
      )

      # prefix and suffix
      configuration.output_suffix = '--show'

      generated_hash = @generated_hash.dup # create a copy rather than just another assignment
      expect(described_class.format_classes(generated_hash)).to eq(
        {
          '.basic-sm|color--current--show' => '@media only screen and (min-width: 324.0) { color: currentColor }',
          '.basic-md|color--current--show' => '@media only screen and (min-width: 767.0) { color: currentColor }',
          '.basic-lg|color--current--show' => '@media only screen and (min-width: 1023.0) { color: currentColor }',
          '.basic-xl|color--current--show' => '@media only screen and (min-width: 1439.0) { color: currentColor }'
        }
      )

      # suffix
      configuration.output_prefix = nil

      generated_hash = @generated_hash.dup # create a copy rather than just another assignment
      expect(described_class.format_classes(generated_hash)).to eq(
        {
          '.sm|color--current--show' => '@media only screen and (min-width: 324.0) { color: currentColor }',
          '.md|color--current--show' => '@media only screen and (min-width: 767.0) { color: currentColor }',
          '.lg|color--current--show' => '@media only screen and (min-width: 1023.0) { color: currentColor }',
          '.xl|color--current--show' => '@media only screen and (min-width: 1439.0) { color: currentColor }'
        }
      )
    end
  end
end
