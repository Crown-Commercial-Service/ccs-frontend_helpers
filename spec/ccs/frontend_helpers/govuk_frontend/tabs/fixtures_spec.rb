# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/tabs'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Tabs, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_tabs from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'tabs' }

    before do
      fixture_options[:items] = fixture_options[:items]&.map do |item|
        tab_item = {
          label: item[:label],
          attributes: item[:attributes]
        }

        tab_item[:panel] = if item[:panel][:html]
                             {
                               content: item[:panel][:html].html_safe
                             }
                           else
                             {
                               text: item[:panel][:text]
                             }
                           end

        tab_item[:panel][:attributes] = item[:panel][:attributes] || {}
        tab_item[:panel][:attributes][:id] = item[:id]

        tab_item
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_tabs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'tabs-with-anchor-in-panel'" do
      let(:fixture_name) { 'tabs-with-anchor-in-panel' }
      let(:result) { govuk_tabs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_tabs(fixture_options[:items], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) { govuk_tabs(fixture_options[:items], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'title'" do
      let(:fixture_name) { 'title' }
      let(:result) { govuk_tabs(fixture_options[:items], fixture_options[:title]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_tabs(fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'item with attributes'" do
      let(:fixture_name) { 'item with attributes' }
      let(:result) { govuk_tabs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'panel with attributes'" do
      let(:fixture_name) { 'panel with attributes' }
      let(:result) { govuk_tabs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'no item list'" do
      let(:fixture_name) { 'no item list' }
      let(:result) { govuk_tabs([], classes: fixture_options[:classes], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'empty item list'" do
      let(:fixture_name) { 'empty item list' }
      let(:result) { govuk_tabs(fixture_options[:items], classes: fixture_options[:classes], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'idPrefix'" do
      let(:fixture_name) { 'idPrefix' }
      let(:result) { govuk_tabs(fixture_options[:items], id_prefix: fixture_options[:idPrefix]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_tabs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_tabs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
