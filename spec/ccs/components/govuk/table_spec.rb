# frozen_string_literal: true

require 'ccs/components/govuk/table'

RSpec.describe CCS::Components::GovUK::Table do
  include_context 'and I have a view context'

  let(:table_element) { Capybara::Node::Simple.new(result).find('table.govuk-table') }
  let(:table_caption_element) { table_element.find('caption.govuk-table__caption') }
  let(:table_head_element) { table_element.find('thead.govuk-table__head') }
  let(:table_row_elements) { table_element.all('tbody > tr') }

  describe '.render' do
    let(:govuk_table) { described_class.new(rows: rows, head_cells: head_cells, caption: caption, first_cell_is_header: first_cell_is_header, context: view_context, **options) }
    let(:result) { govuk_table.render }

    let(:head_cells) { nil }
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
    let(:caption) { nil }
    let(:first_cell_is_header) { nil }
    let(:options) { {} }

    let(:default_html) do
      '
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
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the table' do
        expect(table_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_table) { described_class.new(rows: rows, context: view_context) }

      it 'correctly formats the HTML with the table' do
        expect(table_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(table_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(table_element[:class]).to eq('govuk-table my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(table_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when a caption is present' do
      let(:options) do
        {
          caption: {
            text: 'The memebrs of Ouroboros'
          }.merge(caption_options)
        }
      end
      let(:caption_options) { {} }

      it 'renders the caption in the table' do
        expect(table_element.to_html).to eq('
          <table class="govuk-table">
            <caption class="govuk-table__caption">
              The memebrs of Ouroboros
            </caption>
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

      context 'when additional classes are passed' do
        let(:caption_options) { { classes: 'my-custom-caption-class' } }

        it 'has the custom class' do
          expect(table_caption_element[:class]).to eq('govuk-table__caption my-custom-caption-class')
        end
      end
    end

    context 'when the column head is present' do
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

      it 'renders the head in the table' do
        expect(table_element.to_html).to eq('
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
        '.to_one_line)
      end
    end

    context 'when the caption and head are present' do
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
      let(:options) do
        {
          caption: {
            text: 'The memebrs of Ouroboros'
          }
        }
      end

      it 'renders the caption and head in the table' do
        expect(table_element.to_html).to eq('
          <table class="govuk-table">
            <caption class="govuk-table__caption">
              The memebrs of Ouroboros
            </caption>
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
        '.to_one_line)
      end
    end

    context 'when the first cell is a header' do
      let(:options) { { first_cell_is_header: true } }

      it 'renders with the first cell being th' do
        expect(table_element.to_html).to eq('
          <table class="govuk-table">
            <tbody class="govuk-table__body">
              <tr class="govuk-table__row">
                <th class="govuk-table__header" scope="row">Eunie</th>
                <td class="govuk-table__cell">9th term</td>
                <td class="govuk-table__cell">Medic Gunner</td>
              </tr>
              <tr class="govuk-table__row">
                <th class="govuk-table__header" scope="row">Mio</th>
                <td class="govuk-table__cell">10th term</td>
                <td class="govuk-table__cell">Zephyr</td>
              </tr>
              <tr class="govuk-table__row">
                <th class="govuk-table__header" scope="row">Monica</th>
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
