# frozen_string_literal: true

require 'ccs/components/govuk/table/header/head_cell'

RSpec.describe CCS::Components::GovUK::Table::Header::HeadCell do
  include_context 'and I have a view context'

  let(:table_head_cell_element) { Capybara::Node::Simple.new(result).find('th.govuk-table__header') }

  describe '.render' do
    let(:govuk_table_header_head_cell) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_table_header_head_cell.render }

    let(:text) { 'Name' }
    let(:options) { {} }

    let(:default_html) { '<th class="govuk-table__header" scope="col">Name</th>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the text' do
        expect(table_head_cell_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_table_header_head_cell) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the text' do
        expect(table_head_cell_element.to_html).to eq(default_html)
      end
    end

    context 'and there are additional classes' do
      let(:options) { { classes: 'my-custom-header-class' } }

      it 'has the custom class' do
        expect(table_head_cell_element[:class]).to eq('govuk-table__header my-custom-header-class')
      end
    end

    context 'and the format option is present' do
      let(:options) { { format: 'numeric' } }

      it 'has the numeric class' do
        expect(table_head_cell_element[:class]).to eq('govuk-table__header govuk-table__header--numeric')
      end
    end

    context 'and there are format and additional classes options' do
      let(:options) { { classes: 'my-custom-header-class', format: 'numeric' } }

      it 'has the custom class and format class' do
        expect(table_head_cell_element[:class]).to eq('govuk-table__header my-custom-header-class govuk-table__header--numeric')
      end
    end

    context 'and there are additional attributes' do
      let(:options) { { attributes: { colspan: '2', rowspan: '2', data: { test: 'hello-there' } } } }

      it 'has the additional attributes' do
        expect(table_head_cell_element[:colspan]).to eq('2')
        expect(table_head_cell_element[:rowspan]).to eq('2')
        expect(table_head_cell_element[:'data-test']).to eq('hello-there')
      end
    end
  end
end
