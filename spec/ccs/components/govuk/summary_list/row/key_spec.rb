# frozen_string_literal: true

require 'ccs/components/govuk/summary_list/row/key'

RSpec.describe CCS::Components::GovUK::SummaryList::Row::Key do
  include_context 'and I have a view context'

  let(:summary_list_key_element) { Capybara::Node::Simple.new(result).find('dt.govuk-summary-list__key') }

  describe '.render' do
    let(:govuk_summary_list_key) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_summary_list_key.render }

    let(:text) { 'Name' }
    let(:options) { {} }

    let(:default_html) { '<dt class="govuk-summary-list__key">Name</dt>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary list key' do
        expect(summary_list_key_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_summary_list_key) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the summary list key' do
        expect(summary_list_key_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(summary_list_key_element[:class]).to eq('govuk-summary-list__key my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(summary_list_key_element[:id]).to be_nil
        expect(summary_list_key_element[:'data-test']).to be_nil
      end
    end
  end
end
