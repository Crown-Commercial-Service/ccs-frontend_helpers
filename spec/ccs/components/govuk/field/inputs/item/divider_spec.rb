# frozen_string_literal: true

require 'ccs/components/govuk/field/inputs/item/divider'

RSpec.describe CCS::Components::GovUK::Field::Inputs::Item::Divider do
  let(:item_divider_element) { Capybara::Node::Simple.new(result).find('div') }

  describe '.render' do
    let(:govuk_divider_item) { described_class.new(divider: text, type: type) }
    let(:result) { govuk_divider_item.render }

    context 'when the type is checkboxes' do
      let(:type) { 'checkboxes' }
      let(:text) { 'Checkboxes divider' }

      it 'correctly formats the HTML for the divider' do
        expect(item_divider_element.to_html).to eq('<div class="govuk-checkboxes__divider">Checkboxes divider</div>')
      end
    end

    context 'when the type is radios' do
      let(:type) { 'radios' }
      let(:text) { 'Radios divider' }

      it 'correctly formats the HTML for the divider' do
        expect(item_divider_element.to_html).to eq('<div class="govuk-radios__divider">Radios divider</div>')
      end
    end
  end
end
