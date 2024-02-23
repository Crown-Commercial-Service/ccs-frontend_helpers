# frozen_string_literal: true

require 'ccs/components/govuk/summary_list/card/actions'

RSpec.describe CCS::Components::GovUK::SummaryList::Card::Actions do
  include_context 'and I have a view context'

  let(:summary_card_actions_element) { Capybara::Node::Simple.new(result).find('.govuk-summary-card__actions') }

  describe '.render' do
    let(:govuk_summary_card_actions) { described_class.new(items: items, card_title: card_title, context: view_context, **options) }
    let(:result) { govuk_summary_card_actions.render }

    let(:items) do
      [
        {
          text: 'Delete memebr',
          href: '/delete-member'
        }
      ]
    end
    let(:card_title) { 'Ouroboros members' }
    let(:options) { {} }

    context 'when there is one item' do
      let(:default_html) do
        '
          <div class="govuk-summary-card__actions">
            <a class="govuk-link" href="/delete-member">
              Delete memebr<span class="govuk-visually-hidden"> (Ouroboros members)</span>
            </a>
          </div>
        '.to_one_line
      end

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the summary card action link' do
          expect(summary_card_actions_element.to_html).to eq(default_html)
        end
      end

      context 'when the no options are sent' do
        let(:govuk_summary_card_actions) { described_class.new(items: items, card_title: card_title, context: view_context) }

        it 'correctly formats the HTML with the summary card action link' do
          expect(summary_card_actions_element.to_html).to eq(default_html)
        end
      end
    end

    context 'when there are multiple items' do
      let(:items) do
        [
          {
            text: 'Delete memebr',
            href: '/delete-member'
          },
          {
            text: 'Disable memebr',
            href: '/disable-member'
          }
        ]
      end

      let(:default_html) do
        '
          <ul class="govuk-summary-card__actions">
            <li class="govuk-summary-card__action">
              <a class="govuk-link" href="/delete-member">
                Delete memebr<span class="govuk-visually-hidden"> (Ouroboros members)</span>
              </a>
            </li>
            <li class="govuk-summary-card__action">
              <a class="govuk-link" href="/disable-member">
                Disable memebr<span class="govuk-visually-hidden"> (Ouroboros members)</span>
              </a>
            </li>
          </ul>
        '.to_one_line
      end

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the summary card action links in a list' do
          expect(summary_card_actions_element.to_html).to eq(default_html)
        end
      end

      context 'when the no options are sent' do
        let(:govuk_summary_card_actions) { described_class.new(items: items, card_title: card_title, context: view_context) }

        it 'correctly formats the HTML with the summary card action links in a list' do
          expect(summary_card_actions_element.to_html).to eq(default_html)
        end
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(summary_card_actions_element[:class]).to eq('govuk-summary-card__actions my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(summary_card_actions_element[:id]).to be_nil
        expect(summary_card_actions_element[:'data-test']).to be_nil
      end
    end
  end
end
