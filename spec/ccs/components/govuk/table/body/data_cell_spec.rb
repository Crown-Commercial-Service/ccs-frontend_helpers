# frozen_string_literal: true

require 'ccs/components/govuk/table/body/data_cell'

RSpec.describe CCS::Components::GovUK::Table::Body::DataCell do
  include_context 'and I have a view context'

  let(:table_data_cell_element) { Capybara::Node::Simple.new(result).find('td.govuk-table__cell') }

  describe '.render' do
    let(:govuk_table_body_data_cell) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_table_body_data_cell.render }

    let(:text) { '9th term' }
    let(:options) { {} }

    let(:default_html) { '<td class="govuk-table__cell">9th term</td>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the text' do
        expect(table_data_cell_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_table_body_data_cell) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the text' do
        expect(table_data_cell_element.to_html).to eq(default_html)
      end
    end

    context 'and there are additional classes' do
      let(:options) { { classes: 'my-custom-body-class' } }

      it 'has the custom class' do
        expect(table_data_cell_element[:class]).to eq('govuk-table__cell my-custom-body-class')
      end
    end

    context 'and the format option is present' do
      let(:options) { { format: 'numeric' } }

      it 'has the numeric class' do
        expect(table_data_cell_element[:class]).to eq('govuk-table__cell govuk-table__cell--numeric')
      end
    end

    context 'and there are format and additional classes options' do
      let(:options) { { classes: 'my-custom-body-class', format: 'numeric' } }

      it 'has the custom class and format class' do
        expect(table_data_cell_element[:class]).to eq('govuk-table__cell my-custom-body-class govuk-table__cell--numeric')
      end
    end

    context 'and there are additional attributes' do
      let(:options) { { attributes: { colspan: '2', rowspan: '2', data: { test: 'hello-there' } } } }

      it 'has the additional attributes' do
        expect(table_data_cell_element[:colspan]).to eq('2')
        expect(table_data_cell_element[:rowspan]).to eq('2')
        expect(table_data_cell_element[:'data-test']).to eq('hello-there')
      end
    end
  end
end
