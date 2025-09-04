# frozen_string_literal: true

RSpec.describe UtilityColors::Builders do
  context 'methods' do
    it '.responds_to' do
      expect(described_class).to respond_to(:utility_classes_creation)
      expect(described_class).to respond_to(:utility_pseudo_classes_creation)
      expect(described_class).to respond_to(:utility_breakpoint_classes_creation)
      expect(described_class).to respond_to(:utility_pseudo_breakpoint_classes_creation)

      expect(described_class).to respond_to(:utility_classes)
      expect(described_class).to respond_to(:bulk_breakpoint_class_creation)
      expect(described_class).to respond_to(:bulk_pseudo_class_creation)
      expect(described_class).to respond_to(:bulk_pseudo_breakpoint_class_creation)
    end

    before do
      @class_name = 'color--current'
      @content_str = 'color: currentColor'
      @content_arr = ['background-color', 'currentColor']
      @pseudo = 'hover'
      @initial = 'md'
      @screen_size = 1280

      @class_hash = { 'color--current' => 'color: currentColor;', 'bg--current' => ['background-color', 'currentColor;'] }
    end

    it '.utility_classes_creation' do
      expect(described_class.utility_classes_creation(@class_name, @content_str)).to eq({ 'color--current' => 'color: currentColor;' })
      expect(described_class.utility_classes_creation(@class_name, @content_arr)).to eq({ 'color--current' => 'background-color: currentColor;' })
    end

    # ';' is only added in the above method and content in then reused in the next 3
    it '.utility_pseudo_classes_creation' do
      expect(described_class.utility_pseudo_classes_creation(@class_name, @content_str, @pseudo)).to eq({ 'hover\\|color--current:hover' => 'color: currentColor' })
      expect(described_class.utility_pseudo_classes_creation(@class_name, @content_arr, @pseudo)).to eq({ 'hover\\|color--current:hover' => 'background-color: currentColor' })
    end

    it '.utility_breakpoint_classes_creation' do
      expect(described_class.utility_breakpoint_classes_creation(@class_name, @content_str, @initial, @screen_size)).to eq({ 'md\\|color--current' => '@media only screen and (min-width: 1279) { color: currentColor }' })
      expect(described_class.utility_breakpoint_classes_creation(@class_name, @content_arr, @initial, @screen_size)).to eq({ 'md\\|color--current' => '@media only screen and (min-width: 1279) { background-color: currentColor }' })
    end

    it '.utility_pseudo_breakpoint_classes_creation' do
      expect(described_class.utility_pseudo_breakpoint_classes_creation(@class_name, @content_str, @pseudo, @initial, @screen_size)).to eq({ 'hover\\|md\\|color--current:hover' => '@media only screen and (min-width: 1279) { color: currentColor }' })
      expect(described_class.utility_pseudo_breakpoint_classes_creation(@class_name, @content_arr, @pseudo, @initial, @screen_size)).to eq({ 'hover\\|md\\|color--current:hover' => '@media only screen and (min-width: 1279) { background-color: currentColor }' })
    end

    it '.utility_classes' do
      expect(described_class.utility_classes(@class_name, @content_str)).to eq({ 'color--current' => 'color: currentColor;' })
      expect(described_class.utility_classes(@class_name, @content_arr)).to eq({ 'color--current' => 'background-color: currentColor;' })
    end

    it '.bulk_breakpoint_class_creation' do
      expect(described_class.bulk_breakpoint_class_creation(@class_hash)).to eq(
        {
          'sm\\|color--current' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'sm\\|bg--current' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'md\\|color--current' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'md\\|bg--current' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'lg\\|color--current' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'lg\\|bg--current' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'xl\\|color--current' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'xl\\|bg--current' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }'
        }
      )
    end

    it '.bulk_pseudo_class_creation' do
      expect(described_class.bulk_pseudo_class_creation(@class_hash)).to eq(
        {
          'active\\|bg--current:active' => 'background-color: currentColor;',
          'active\\|color--current:active' => 'color: currentColor;',
          'checked\\|bg--current:checked' => 'background-color: currentColor;',
          'checked\\|color--current:checked' => 'color: currentColor;',
          'disabled\\|bg--current:disabled' => 'background-color: currentColor;',
          'disabled\\|color--current:disabled' => 'color: currentColor;',
          'empty\\|bg--current:empty' => 'background-color: currentColor;',
          'empty\\|color--current:empty' => 'color: currentColor;',
          'enabled\\|bg--current:enabled' => 'background-color: currentColor;',
          'enabled\\|color--current:enabled' => 'color: currentColor;',
          'first-child\\|bg--current:first-child' => 'background-color: currentColor;',
          'first-child\\|color--current:first-child' => 'color: currentColor;',
          'first-of-type\\|bg--current:first-of-type' => 'background-color: currentColor;',
          'first-of-type\\|color--current:first-of-type' => 'color: currentColor;',
          'focus\\|bg--current:focus' => 'background-color: currentColor;',
          'focus\\|color--current:focus' => 'color: currentColor;',
          'hover\\|bg--current:hover' => 'background-color: currentColor;',
          'hover\\|color--current:hover' => 'color: currentColor;',
          'last-child\\|bg--current:last-child' => 'background-color: currentColor;',
          'last-child\\|color--current:last-child' => 'color: currentColor;',
          'last-of-type\\|bg--current:last-of-type' => 'background-color: currentColor;',
          'last-of-type\\|color--current:last-of-type' => 'color: currentColor;',
          'link\\|bg--current:link' => 'background-color: currentColor;',
          'link\\|color--current:link' => 'color: currentColor;',
          'only-child\\|bg--current:only-child' => 'background-color: currentColor;',
          'only-child\\|color--current:only-child' => 'color: currentColor;',
          'only-of-type\\|bg--current:only-of-type' => 'background-color: currentColor;',
          'only-of-type\\|color--current:only-of-type' => 'color: currentColor;',
          'root\\|bg--current:root' => 'background-color: currentColor;',
          'root\\|color--current:root' => 'color: currentColor;',
          'target\\|bg--current:target' => 'background-color: currentColor;',
          'target\\|color--current:target' => 'color: currentColor;',
          'visited\\|bg--current:visited' => 'background-color: currentColor;',
          'visited\\|color--current:visited' => 'color: currentColor;'
        }
      )
    end

    it '.bulk_pseudo_breakpoint_class_creation' do
      expect(described_class.bulk_pseudo_breakpoint_class_creation(@class_hash)).to eq(
        {
          'active\\|sm\\|bg--current:active' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'active\\|sm\\|color--current:active' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'active\\|md\\|bg--current:active' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'active\\|md\\|color--current:active' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'active\\|lg\\|bg--current:active' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'active\\|lg\\|color--current:active' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'active\\|xl\\|bg--current:active' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'active\\|xl\\|color--current:active' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'checked\\|sm\\|bg--current:checked' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'checked\\|sm\\|color--current:checked' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'checked\\|md\\|bg--current:checked' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'checked\\|md\\|color--current:checked' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'checked\\|lg\\|bg--current:checked' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'checked\\|lg\\|color--current:checked' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'checked\\|xl\\|bg--current:checked' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'checked\\|xl\\|color--current:checked' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'disabled\\|sm\\|bg--current:disabled' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'disabled\\|sm\\|color--current:disabled' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'disabled\\|md\\|bg--current:disabled' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'disabled\\|md\\|color--current:disabled' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'disabled\\|lg\\|bg--current:disabled' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'disabled\\|lg\\|color--current:disabled' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'disabled\\|xl\\|bg--current:disabled' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'disabled\\|xl\\|color--current:disabled' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'empty\\|sm\\|bg--current:empty' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'empty\\|sm\\|color--current:empty' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'empty\\|md\\|bg--current:empty' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'empty\\|md\\|color--current:empty' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'empty\\|lg\\|bg--current:empty' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'empty\\|lg\\|color--current:empty' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'empty\\|xl\\|bg--current:empty' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'empty\\|xl\\|color--current:empty' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'enabled\\|sm\\|bg--current:enabled' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'enabled\\|sm\\|color--current:enabled' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'enabled\\|md\\|bg--current:enabled' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'enabled\\|md\\|color--current:enabled' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'enabled\\|lg\\|bg--current:enabled' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'enabled\\|lg\\|color--current:enabled' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'enabled\\|xl\\|bg--current:enabled' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'enabled\\|xl\\|color--current:enabled' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'first-child\\|sm\\|bg--current:first-child' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'first-child\\|sm\\|color--current:first-child' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'first-child\\|md\\|bg--current:first-child' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'first-child\\|md\\|color--current:first-child' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'first-child\\|lg\\|bg--current:first-child' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'first-child\\|lg\\|color--current:first-child' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'first-child\\|xl\\|bg--current:first-child' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'first-child\\|xl\\|color--current:first-child' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'first-of-type\\|sm\\|bg--current:first-of-type' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'first-of-type\\|sm\\|color--current:first-of-type' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'first-of-type\\|md\\|bg--current:first-of-type' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'first-of-type\\|md\\|color--current:first-of-type' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'first-of-type\\|lg\\|bg--current:first-of-type' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'first-of-type\\|lg\\|color--current:first-of-type' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'first-of-type\\|xl\\|bg--current:first-of-type' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'first-of-type\\|xl\\|color--current:first-of-type' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'focus\\|sm\\|bg--current:focus' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'focus\\|sm\\|color--current:focus' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'focus\\|md\\|bg--current:focus' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'focus\\|md\\|color--current:focus' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'focus\\|lg\\|bg--current:focus' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'focus\\|lg\\|color--current:focus' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'focus\\|xl\\|bg--current:focus' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'focus\\|xl\\|color--current:focus' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'hover\\|sm\\|bg--current:hover' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'hover\\|sm\\|color--current:hover' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'hover\\|md\\|bg--current:hover' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'hover\\|md\\|color--current:hover' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'hover\\|lg\\|bg--current:hover' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'hover\\|lg\\|color--current:hover' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'hover\\|xl\\|bg--current:hover' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'hover\\|xl\\|color--current:hover' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'last-child\\|sm\\|bg--current:last-child' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'last-child\\|sm\\|color--current:last-child' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'last-child\\|md\\|bg--current:last-child' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'last-child\\|md\\|color--current:last-child' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'last-child\\|lg\\|bg--current:last-child' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'last-child\\|lg\\|color--current:last-child' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'last-child\\|xl\\|bg--current:last-child' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'last-child\\|xl\\|color--current:last-child' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'last-of-type\\|sm\\|bg--current:last-of-type' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'last-of-type\\|sm\\|color--current:last-of-type' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'last-of-type\\|md\\|bg--current:last-of-type' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'last-of-type\\|md\\|color--current:last-of-type' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'last-of-type\\|lg\\|bg--current:last-of-type' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'last-of-type\\|lg\\|color--current:last-of-type' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'last-of-type\\|xl\\|bg--current:last-of-type' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'last-of-type\\|xl\\|color--current:last-of-type' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'link\\|sm\\|bg--current:link' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'link\\|sm\\|color--current:link' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'link\\|md\\|bg--current:link' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'link\\|md\\|color--current:link' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'link\\|lg\\|bg--current:link' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'link\\|lg\\|color--current:link' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'link\\|xl\\|bg--current:link' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'link\\|xl\\|color--current:link' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'only-child\\|sm\\|bg--current:only-child' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'only-child\\|sm\\|color--current:only-child' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'only-child\\|md\\|bg--current:only-child' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'only-child\\|md\\|color--current:only-child' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'only-child\\|lg\\|bg--current:only-child' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'only-child\\|lg\\|color--current:only-child' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'only-child\\|xl\\|bg--current:only-child' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'only-child\\|xl\\|color--current:only-child' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'only-of-type\\|sm\\|bg--current:only-of-type' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'only-of-type\\|sm\\|color--current:only-of-type' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'only-of-type\\|md\\|bg--current:only-of-type' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'only-of-type\\|md\\|color--current:only-of-type' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'only-of-type\\|lg\\|bg--current:only-of-type' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'only-of-type\\|lg\\|color--current:only-of-type' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'only-of-type\\|xl\\|bg--current:only-of-type' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'only-of-type\\|xl\\|color--current:only-of-type' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'root\\|sm\\|bg--current:root' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'root\\|sm\\|color--current:root' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'root\\|md\\|bg--current:root' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'root\\|md\\|color--current:root' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'root\\|lg\\|bg--current:root' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'root\\|lg\\|color--current:root' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'root\\|xl\\|bg--current:root' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'root\\|xl\\|color--current:root' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'target\\|sm\\|bg--current:target' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'target\\|sm\\|color--current:target' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'target\\|md\\|bg--current:target' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'target\\|md\\|color--current:target' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'target\\|lg\\|bg--current:target' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'target\\|lg\\|color--current:target' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'target\\|xl\\|bg--current:target' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'target\\|xl\\|color--current:target' => '@media only screen and (min-width: 1439.0) { color: currentColor; }',
          'visited\\|sm\\|bg--current:visited' => '@media only screen and (min-width: 324.0) { background-color: currentColor; }',
          'visited\\|sm\\|color--current:visited' => '@media only screen and (min-width: 324.0) { color: currentColor; }',
          'visited\\|md\\|bg--current:visited' => '@media only screen and (min-width: 767.0) { background-color: currentColor; }',
          'visited\\|md\\|color--current:visited' => '@media only screen and (min-width: 767.0) { color: currentColor; }',
          'visited\\|lg\\|bg--current:visited' => '@media only screen and (min-width: 1023.0) { background-color: currentColor; }',
          'visited\\|lg\\|color--current:visited' => '@media only screen and (min-width: 1023.0) { color: currentColor; }',
          'visited\\|xl\\|bg--current:visited' => '@media only screen and (min-width: 1439.0) { background-color: currentColor; }',
          'visited\\|xl\\|color--current:visited' => '@media only screen and (min-width: 1439.0) { color: currentColor; }'
        }
      )
    end
  end
end
