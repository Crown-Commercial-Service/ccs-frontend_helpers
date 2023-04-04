# frozen_string_literal: true

require 'ccs/components/govuk/summary_list/row'

RSpec.describe CCS::Components::GovUK::SummaryList::Row do
  include_context 'and I have a view context'

  let(:summary_list_row_element) { Capybara::Node::Simple.new(result).find('div.govuk-summary-list__row') }

  describe '.render' do
    let(:govuk_summary_list_rows) { described_class.new(any_row_has_actions: any_row_has_actions, key: key, value: value, actions: actions, context: view_context, **options) }
    let(:result) { govuk_summary_list_rows.render }

    let(:any_row_has_actions) { true }
    let(:key) { { text: 'Name' } }
    let(:value) { { text: 'Eunie' } }
    let(:actions) do
      {
        items: [
          {
            href: '/change-name',
            text: 'Change'
          }
        ]
      }
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-summary-list__row">
          <dt class="govuk-summary-list__key">
            Name
          </dt>
          <dd class="govuk-summary-list__value">
            Eunie
          </dd>
          <dd class="govuk-summary-list__actions">
            <a class="govuk-link" href="/change-name">
              Change
            </a>
          </dd>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary list row' do
        expect(summary_list_row_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_summary_list_rows) { described_class.new(any_row_has_actions: any_row_has_actions, key: key, value: value, actions: actions, context: view_context) }

      it 'correctly formats the HTML with the summary list row' do
        expect(summary_list_row_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(summary_list_row_element[:class]).to eq('govuk-summary-list__row my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(summary_list_row_element[:id]).to be_nil
        expect(summary_list_row_element[:'data-test']).to be_nil
      end
    end

    context 'when there are no actions' do
      let(:actions) { nil }

      it 'does not render the actions section' do
        expect(summary_list_row_element).not_to have_css('dd.govuk-summary-list__actions')
      end

      it 'has the no actions class' do
        expect(summary_list_row_element[:class]).to eq('govuk-summary-list__row govuk-summary-list__row--no-actions')
      end

      context 'and no rows have actions' do
        let(:any_row_has_actions) { false }

        it 'does not have the no actions class' do
          expect(summary_list_row_element[:class]).to eq('govuk-summary-list__row')
        end
      end
    end
  end
end
