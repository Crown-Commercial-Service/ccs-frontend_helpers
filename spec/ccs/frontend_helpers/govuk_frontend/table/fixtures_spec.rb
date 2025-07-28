# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/table'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Table, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_table from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'table' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_table(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with head'" do
      let(:fixture_name) { 'with head' }
      let(:result) { govuk_table(fixture_options[:head], fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with head and caption'" do
      let(:fixture_name) { 'with head and caption' }
      let(:result) { govuk_table(fixture_options[:head], fixture_options[:rows], caption: { text: fixture_options[:caption], classes: fixture_options[:captionClasses] }, first_cell_is_header: fixture_options[:firstCellIsHeader]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with small text modifier for tables with a lot of data'" do
      let(:fixture_name) { 'with small text modifier for tables with a lot of data' }
      let(:result) { govuk_table(fixture_options[:rows], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_table(fixture_options[:rows], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_table(fixture_options[:rows], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_table(fixture_options[:head], fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_table(fixture_options[:head].map { |head| { text: head[:html].html_safe } }, fixture_options[:rows].map { |rows| rows.map { |row| { text: row[:html].html_safe } } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'head with classes'" do
      let(:fixture_name) { 'head with classes' }
      let(:result) { govuk_table(fixture_options[:head], fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'head with rowspan and colspan'" do
      let(:fixture_name) { 'head with rowspan and colspan' }
      let(:result) { govuk_table(fixture_options[:head].map { |head| { text: head[:text], attributes: { rowspan: head[:rowspan], colspan: head[:colspan] } } }, fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'head with attributes'" do
      let(:fixture_name) { 'head with attributes' }
      let(:result) { govuk_table(fixture_options[:head], fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with firstCellIsHeader true'" do
      let(:fixture_name) { 'with firstCellIsHeader true' }
      let(:result) { govuk_table(fixture_options[:rows], first_cell_is_header: fixture_options[:firstCellIsHeader]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'firstCellIsHeader with classes'" do
      let(:fixture_name) { 'firstCellIsHeader with classes' }
      let(:result) { govuk_table(fixture_options[:rows], first_cell_is_header: fixture_options[:firstCellIsHeader]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'firstCellIsHeader with html'" do
      let(:fixture_name) { 'firstCellIsHeader with html' }
      let(:result) { govuk_table(fixture_options[:rows].map { |rows| rows.map { |row| { text: row[:html].html_safe } } }, first_cell_is_header: fixture_options[:firstCellIsHeader]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'firstCellIsHeader with html as text'" do
      let(:fixture_name) { 'firstCellIsHeader with html as text' }
      let(:result) { govuk_table(fixture_options[:rows], first_cell_is_header: fixture_options[:firstCellIsHeader]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'firstCellIsHeader with rowspan and colspan'" do
      let(:fixture_name) { 'firstCellIsHeader with rowspan and colspan' }
      let(:result) { govuk_table(fixture_options[:rows].map { |rows| rows.map { |row| { text: row[:text], attributes: { rowspan: row[:rowspan], colspan: row[:colspan] } } } }, first_cell_is_header: fixture_options[:firstCellIsHeader]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'firstCellIsHeader with attributes'" do
      let(:fixture_name) { 'firstCellIsHeader with attributes' }
      let(:result) { govuk_table(fixture_options[:rows], first_cell_is_header: fixture_options[:firstCellIsHeader]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'rows with classes'" do
      let(:fixture_name) { 'rows with classes' }
      let(:result) { govuk_table(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'rows with rowspan and colspan'" do
      let(:fixture_name) { 'rows with rowspan and colspan' }
      let(:result) { govuk_table(fixture_options[:rows].map { |rows| rows.map { |row| { text: row[:text], attributes: { rowspan: row[:rowspan], colspan: row[:colspan] } } } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'rows with attributes'" do
      let(:fixture_name) { 'rows with attributes' }
      let(:result) { govuk_table(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
