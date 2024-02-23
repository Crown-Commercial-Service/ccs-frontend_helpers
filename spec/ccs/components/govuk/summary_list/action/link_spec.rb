# frozen_string_literal: true

require 'ccs/components/govuk/summary_list/action/link'

RSpec.describe CCS::Components::GovUK::SummaryList::Action::Link do
  include_context 'and I have a view context'

  let(:summary_list_action_link_element) { Capybara::Node::Simple.new(result).find('a') }

  describe '.render' do
    let(:govuk_summary_list_action_link) { described_class.new(text: text, href: href, visually_hidden_text: visually_hidden_text, card_title: card_title, context: view_context, **options) }
    let(:result) { govuk_summary_list_action_link.render }

    let(:text) { 'Change' }
    let(:href) { '/change-name' }
    let(:visually_hidden_text) { nil }
    let(:card_title) { nil }
    let(:options) { {} }

    let(:default_html) { '<a class="govuk-link" href="/change-name">Change</a>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary list action link' do
        expect(summary_list_action_link_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_summary_list_action_link) { described_class.new(text: text, href: href, context: view_context) }

      it 'correctly formats the HTML with the summary list action link' do
        expect(summary_list_action_link_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(summary_list_action_link_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(summary_list_action_link_element[:class]).to eq('govuk-link my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(summary_list_action_link_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when there is visually hidden text' do
      let(:visually_hidden_text) { 'name' }

      it 'has the visually hidden text' do
        expect(summary_list_action_link_element.to_html).to eq('
          <a class="govuk-link" href="/change-name">
            Change<span class="govuk-visually-hidden"> name</span>
          </a>
        '.to_one_line)
      end
    end

    context 'when there is a card title' do
      let(:card_title) { 'Ouroboros members' }

      it 'has the visually hidden text' do
        expect(summary_list_action_link_element.to_html).to eq('
          <a class="govuk-link" href="/change-name">
            Change<span class="govuk-visually-hidden"> (Ouroboros members)</span>
          </a>
        '.to_one_line)
      end
    end

    context 'when there is visually hidden text and a card title' do
      let(:visually_hidden_text) { 'name' }
      let(:card_title) { 'Ouroboros members' }

      it 'has the visually hidden text' do
        expect(summary_list_action_link_element.to_html).to eq('
          <a class="govuk-link" href="/change-name">
            Change<span class="govuk-visually-hidden"> name (Ouroboros members)</span>
          </a>
        '.to_one_line)
      end
    end
  end
end
