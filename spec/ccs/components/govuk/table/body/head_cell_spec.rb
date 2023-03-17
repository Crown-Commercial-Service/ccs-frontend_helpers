# frozen_string_literal: true

require 'ccs/components/govuk/table/body/head_cell'

RSpec.describe CCS::Components::GovUK::Table::Body::HeadCell do
  include_context 'and I have a view context'

  let(:table_head_cell_element) { Capybara::Node::Simple.new(result).find('th.govuk-table__header') }

  describe '.render' do
    let(:govuk_table_body_head_cell) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_table_body_head_cell.render }

    let(:text) { 'Eunie' }
    let(:options) { {} }

    let(:default_html) { '<th class="govuk-table__header" scope="row">Eunie</th>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the text' do
        expect(table_head_cell_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_table_body_head_cell) { described_class.new(text: text, context: view_context) }

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
