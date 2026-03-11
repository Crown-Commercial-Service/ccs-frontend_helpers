# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/header'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Header, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_header from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'header' }
    let(:fixture_html) { fixture[:html].to_one_line.gsub('svgfocusable', 'svg focusable') }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_header }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with product name'" do
      let(:fixture_name) { 'with product name' }
      let(:result) { govuk_header(product_name: fixture_options[:productName]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'full width'" do
      let(:fixture_name) { 'full width' }
      let(:result) { govuk_header(product_name: fixture_options[:productName], container_classes: fixture_options[:containerClasses]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_header(attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_header(classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom homepage url'" do
      let(:fixture_name) { 'custom homepage url' }
      let(:result) { govuk_header(homepage_url: fixture_options[:homepageUrl]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
