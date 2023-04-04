# frozen_string_literal: true

require 'ccs/components/govuk/summary_list/card/title'

RSpec.describe CCS::Components::GovUK::SummaryList::Card::Title do
  include_context 'and I have a view context'

  let(:summary_card_title_element) { Capybara::Node::Simple.new(result).find('.govuk-summary-card__title') }

  describe '.render' do
    let(:govuk_summary_card_title) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_summary_card_title.render }

    let(:text) { 'Ouroboros members' }
    let(:options) { {} }

    let(:default_html) { '<h2 class="govuk-summary-card__title">Ouroboros members</h2>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary card title' do
        expect(summary_card_title_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_summary_card_title) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the summary card title' do
        expect(summary_card_title_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(summary_card_title_element[:class]).to eq('govuk-summary-card__title my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(summary_card_title_element[:id]).to be_nil
        expect(summary_card_title_element[:'data-test']).to be_nil
      end
    end

    context 'when a custom heading level is sent' do
      let(:options) { { heading_level: '4' } }

      it 'correctly formats the HTML with the heading level of 4' do
        expect(summary_card_title_element.to_html).to eq('<h4 class="govuk-summary-card__title">Ouroboros members</h4>')
      end
    end
  end
end
