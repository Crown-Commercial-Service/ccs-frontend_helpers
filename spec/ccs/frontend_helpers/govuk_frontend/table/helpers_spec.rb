# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/table'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Table, '#helpers', type: :helper do
  include described_class

  let(:table_element) { Capybara::Node::Simple.new(result).find('table.govuk-table') }

  describe '.govuk_table' do
    let(:result) { govuk_table(head_cells, rows, **options) }

    let(:head_cells) do
      [
        {
          text: 'Name'
        },
        {
          text: 'Age'
        },
        {
          text: 'Class'
        }
      ]
    end
    let(:rows) do
      [
        [
          {
            text: 'Eunie'
          },
          {
            text: '9th term'
          },
          {
            text: 'Medic Gunner'
          }
        ],
        [
          {
            text: 'Mio'
          },
          {
            text: '10th term'
          },
          {
            text: 'Zephyr'
          }
        ],
        [
          {
            text: 'Monica'
          },
          {
            text: '33'
          },
          {
            text: 'Lost Vanguard'
          }
        ]
      ]
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <table class="govuk-table">
          <thead class="govuk-table__head">
            <tr class="govuk-table__row">
              <th class="govuk-table__header" scope="col">Name</th>
              <th class="govuk-table__header" scope="col">Age</th>
              <th class="govuk-table__header" scope="col">Class</th>
            </tr>
          </thead>
          <tbody class="govuk-table__body">
            <tr class="govuk-table__row">
              <td class="govuk-table__cell">Eunie</td>
              <td class="govuk-table__cell">9th term</td>
              <td class="govuk-table__cell">Medic Gunner</td>
            </tr>
            <tr class="govuk-table__row">
              <td class="govuk-table__cell">Mio</td>
              <td class="govuk-table__cell">10th term</td>
              <td class="govuk-table__cell">Zephyr</td>
            </tr>
            <tr class="govuk-table__row">
              <td class="govuk-table__cell">Monica</td>
              <td class="govuk-table__cell">33</td>
              <td class="govuk-table__cell">Lost Vanguard</td>
            </tr>
          </tbody>
        </table>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the table' do
        expect(table_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_table(head_cells, rows) }

      it 'correctly formats the HTML with the table' do
        expect(table_element.to_html).to eq(default_html)
      end
    end

    context 'when there are no head cells' do
      let(:result) { govuk_table(rows, **options) }

      it 'correctly formats the HTML with only the table rows' do
        expect(table_element.to_html).to eq('
          <table class="govuk-table">
            <tbody class="govuk-table__body">
              <tr class="govuk-table__row">
                <td class="govuk-table__cell">Eunie</td>
                <td class="govuk-table__cell">9th term</td>
                <td class="govuk-table__cell">Medic Gunner</td>
              </tr>
              <tr class="govuk-table__row">
                <td class="govuk-table__cell">Mio</td>
                <td class="govuk-table__cell">10th term</td>
                <td class="govuk-table__cell">Zephyr</td>
              </tr>
              <tr class="govuk-table__row">
                <td class="govuk-table__cell">Monica</td>
                <td class="govuk-table__cell">33</td>
                <td class="govuk-table__cell">Lost Vanguard</td>
              </tr>
            </tbody>
          </table>
        '.to_one_line)
      end
    end
  end
end
