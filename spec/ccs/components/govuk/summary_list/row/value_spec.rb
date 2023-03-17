# frozen_string_literal: true

require 'ccs/components/govuk/summary_list/row/value'

RSpec.describe CCS::Components::GovUK::SummaryList::Row::Value do
  include_context 'and I have a view context'

  let(:summary_list_value_element) { Capybara::Node::Simple.new(result).find('dd.govuk-summary-list__value') }

  describe '.render' do
    let(:govuk_summary_list_value) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_summary_list_value.render }

    let(:text) { 'Eunie' }
    let(:options) { {} }

    let(:default_html) { '<dd class="govuk-summary-list__value">Eunie</dd>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary list value' do
        expect(summary_list_value_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_summary_list_value) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the summary list value' do
        expect(summary_list_value_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(summary_list_value_element[:class]).to eq('govuk-summary-list__value my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(summary_list_value_element[:id]).to be_nil
        expect(summary_list_value_element[:'data-test']).to be_nil
      end
    end
  end
end
