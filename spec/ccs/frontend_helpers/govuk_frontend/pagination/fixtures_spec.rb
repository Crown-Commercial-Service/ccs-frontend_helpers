# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/pagination'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Pagination, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_pagination from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'pagination' }

    before do
      %i[previous next items].each do |attribute|
        if fixture_options[attribute]
          fixture_options[:"pagination_#{attribute}"] = fixture_options[attribute]
          fixture_options.delete(attribute)
        end
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom navigation landmark'" do
      let(:fixture_name) { 'with custom navigation landmark' }
      let(:result) { govuk_pagination(**fixture_options) }

      before do
        fixture_options[:attributes] = { aria: { label: fixture_options[:landmarkLabel] } }
        fixture_options.delete(:landmarkLabel)
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom link and item text'" do
      let(:fixture_name) { 'with custom link and item text' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom accessible labels on item links'" do
      let(:fixture_name) { 'with custom accessible labels on item links' }
      let(:result) { govuk_pagination(**fixture_options) }

      before do
        fixture_options[:pagination_items].each do |item|
          item[:attributes] = { aria: { label: item[:visuallyHiddenText] } }
          item.delete(:visuallyHiddenText)
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with many pages'" do
      let(:fixture_name) { 'with many pages' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('&ctdot;', '⋯'))
      end
    end

    context "when the fixture is 'first page'" do
      let(:fixture_name) { 'first page' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'last page'" do
      let(:fixture_name) { 'last page' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prev and next only'" do
      let(:fixture_name) { 'with prev and next only' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prev and next only and labels'" do
      let(:fixture_name) { 'with prev and next only and labels' }
      let(:result) { govuk_pagination(**fixture_options) }

      before do
        %i[previous next].each do |attribute|
          fixture_options[:"pagination_#{attribute}"][:label_text] = fixture_options[:"pagination_#{attribute}"][:labelText]
          fixture_options[:"pagination_#{attribute}"].delete(:labelText)
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prev and next only and very long labels'" do
      let(:fixture_name) { 'with prev and next only and very long labels' }
      let(:result) { govuk_pagination(**fixture_options) }

      before do
        %i[previous next].each do |attribute|
          fixture_options[:"pagination_#{attribute}"][:label_text] = fixture_options[:"pagination_#{attribute}"][:labelText]
          fixture_options[:"pagination_#{attribute}"].delete(:labelText)
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prev and next only in a different language'" do
      let(:fixture_name) { 'with prev and next only in a different language' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with previous only'" do
      let(:fixture_name) { 'with previous only' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with next only'" do
      let(:fixture_name) { 'with next only' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom classes'" do
      let(:fixture_name) { 'with custom classes' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom attributes'" do
      let(:fixture_name) { 'with custom attributes' }
      let(:result) { govuk_pagination(**fixture_options) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
