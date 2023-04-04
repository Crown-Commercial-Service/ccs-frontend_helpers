# frozen_string_literal: true

require 'ccs/components/govuk/summary_list/row/actions'

RSpec.describe CCS::Components::GovUK::SummaryList::Row::Actions do
  include_context 'and I have a view context'

  let(:summary_list_actions_element) { Capybara::Node::Simple.new(result).find('dd.govuk-summary-list__actions') }

  describe '.render' do
    let(:govuk_summary_list_actions) { described_class.new(items: items, context: view_context, **options) }
    let(:result) { govuk_summary_list_actions.render }

    let(:items) do
      [
        {
          href: '/change-name',
          text: 'Change'
        }
      ]
    end
    let(:options) { {} }

    context 'when there is one item' do
      let(:default_html) do
        '
          <dd class="govuk-summary-list__actions">
            <a class="govuk-link" href="/change-name">
              Change
            </a>
          </dd>
        '.to_one_line
      end

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the summary list action link' do
          expect(summary_list_actions_element.to_html).to eq(default_html)
        end
      end

      context 'when the no options are sent' do
        let(:govuk_summary_list_actions) { described_class.new(items: items, context: view_context) }

        it 'correctly formats the HTML with the summary list action link' do
          expect(summary_list_actions_element.to_html).to eq(default_html)
        end
      end
    end

    context 'when there are multiple items' do
      let(:items) do
        [
          {
            href: '/change-name',
            text: 'Change'
          },
          {
            href: '/return-to-cycle',
            text: 'Return to the cycle'
          }
        ]
      end

      let(:default_html) do
        '
          <dd class="govuk-summary-list__actions">
            <ul class="govuk-summary-list__actions-list">
              <li class="govuk-summary-list__actions-list-item">
                <a class="govuk-link" href="/change-name">
                  Change
                </a>
              </li>
              <li class="govuk-summary-list__actions-list-item">
                <a class="govuk-link" href="/return-to-cycle">
                  Return to the cycle
                </a>
              </li>
            </ul>
          </dd>
        '.to_one_line
      end

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the summary list action links in a list' do
          expect(summary_list_actions_element.to_html).to eq(default_html)
        end
      end

      context 'when the no options are sent' do
        let(:govuk_summary_list_actions) { described_class.new(items: items, context: view_context) }

        it 'correctly formats the HTML with the summary list action links in a list' do
          expect(summary_list_actions_element.to_html).to eq(default_html)
        end
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(summary_list_actions_element[:class]).to eq('govuk-summary-list__actions my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(summary_list_actions_element[:id]).to be_nil
        expect(summary_list_actions_element[:'data-test']).to be_nil
      end
    end
  end
end
