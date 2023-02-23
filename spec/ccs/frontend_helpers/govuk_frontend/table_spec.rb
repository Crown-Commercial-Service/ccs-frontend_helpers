# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/table'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Table, type: :helper do
  include described_class

  let(:table_element) { Capybara::Node::Simple.new(result).find('table.govuk-table') }
  let(:table_caption_element) { table_element.find('caption.govuk-table__caption') }
  let(:table_head_element) { table_element.find('thead.govuk-table__head') }
  let(:table_row_elements) { table_element.all('tbody > tr') }

  describe '.govuk_table' do
    let(:result) { govuk_table(rows, head, **options) }

    let(:head) { nil }
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
      let(:result) { govuk_table(rows) }

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
      let(:head) do
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

      context 'and there are additional classes' do
        let(:head) do
          [
            {
              text: 'Name',
              classes: 'my-custom-header-class'
            }
          ]
        end

        it 'has the custom class' do
          expect(table_head_element.find('tr > th')[:class]).to eq('govuk-table__header my-custom-header-class')
        end
      end

      context 'when there are cells with format' do
        let(:head) do
          [
            {
              text: 'Name',
              format: 'numeric'
            }
          ]
        end

        it 'has the numeric class' do
          expect(table_head_element.find('tr > th')[:class]).to eq('govuk-table__header govuk-table__header--numeric')
        end
      end

      context 'and there are cells with format and additional classes' do
        let(:head) do
          [
            {
              text: 'Name',
              classes: 'my-custom-header-class',
              format: 'numeric'
            }
          ]
        end

        it 'has the custom class and format class' do
          expect(table_head_element.find('tr > th')[:class]).to eq('govuk-table__header my-custom-header-class govuk-table__header--numeric')
        end
      end

      context 'and there are additional attributes' do
        let(:head) do
          [
            {
              text: 'Name',
              attributes: {
                colspan: '2',
                rowspan: '2',
                data: {
                  test: 'hello-there'
                }
              }
            }
          ]
        end

        it 'has the additional attributes' do
          table_head_cell = table_head_element.find('tr > th')

          expect(table_head_cell[:colspan]).to eq('2')
          expect(table_head_cell[:rowspan]).to eq('2')
          expect(table_head_cell[:'data-test']).to eq('hello-there')
        end
      end
    end

    context 'when the caption and head are present' do
      let(:head) do
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

      context 'when the header cell has additional classes' do
        let(:rows) do
          [
            [
              {
                text: 'Eunie',
                classes: 'my-custom-cell-header-class'
              },
              {
                text: '9th term'
              },
              {
                text: 'Medic Gunner'
              }
            ]
          ]
        end

        it 'has the custom class' do
          expect(table_row_elements.first.find('th')[:class]).to eq('govuk-table__header my-custom-cell-header-class')
        end
      end

      context 'when the header cell has additional attributes' do
        let(:rows) do
          [
            [
              {
                text: 'Eunie',
                attributes: {
                  colspan: '2',
                  rowspan: '2',
                  data: {
                    test: 'hello-there'
                  }
                }
              },
              {
                text: '9th term'
              },
              {
                text: 'Medic Gunner'
              }
            ]
          ]
        end

        it 'has the additional attributes' do
          table_row_cell = table_row_elements.first.find('th')

          expect(table_row_cell[:colspan]).to eq('2')
          expect(table_row_cell[:rowspan]).to eq('2')
          expect(table_row_cell[:'data-test']).to eq('hello-there')
        end
      end
    end

    context 'when custom paramaters are being passed to the rows' do
      let(:table_cell_elements) { table_row_elements.first.all('td.govuk-table__cell') }

      let(:rows) do
        [
          [
            {
              text: 'Eunie',
            }.merge(custom_row_attributes),
            {
              text: '9th term'
            }.merge(custom_row_attributes),
            {
              text: 'Medic Gunner'
            }.merge(custom_row_attributes)
          ]
        ]
      end
      let(:custom_row_attributes) { {} }

      context 'and there are additional classes' do
        let(:custom_row_attributes) { { classes: 'my-custom-cell-class' } }

        it 'has the custom class' do
          table_cell_elements.each do |table_cell_element|
            expect(table_cell_element[:class]).to eq('govuk-table__cell my-custom-cell-class')
          end
        end
      end

      context 'when there are cells with format' do
        let(:custom_row_attributes) { { format: 'numeric' } }

        it 'has the numeric class' do
          table_cell_elements.each do |table_cell_element|
            expect(table_cell_element[:class]).to eq('govuk-table__cell govuk-table__cell--numeric')
          end
        end
      end

      context 'and there are cells with format and additional classes' do
        let(:custom_row_attributes) { { classes: 'my-custom-cell-class', format: 'numeric' } }

        it 'has the custom class' do
          table_cell_elements.each do |table_cell_element|
            expect(table_cell_element[:class]).to eq('govuk-table__cell my-custom-cell-class govuk-table__cell--numeric')
          end
        end
      end

      context 'and there are additional attributes' do
        let(:custom_row_attributes) do
          {
            attributes: {
              colspan: '2',
              rowspan: '2',
              data: {
                test: 'hello-there'
              }
            }
          }
        end

        it 'has the additional attributes' do
          table_cell_elements.each do |table_cell_element|
            expect(table_cell_element[:colspan]).to eq('2')
            expect(table_cell_element[:rowspan]).to eq('2')
            expect(table_cell_element[:'data-test']).to eq('hello-there')
          end
        end
      end
    end
  end
end
