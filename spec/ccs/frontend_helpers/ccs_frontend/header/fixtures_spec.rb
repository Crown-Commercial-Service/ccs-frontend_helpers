# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/header'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Header, '#fixtures', type: :helper do
  include described_class

  describe '.ccs_header from fixtures' do
    include_context 'and I have loaded the CCS Frontend fixture'

    let(:component_name) { 'header' }
    let(:fixture_html) { fixture[:html].to_one_line }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { ccs_header }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'full width'" do
      let(:fixture_name) { 'full width' }
      let(:result) { ccs_header(container_classes: fixture_options[:containerClasses], navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { ccs_header(attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { ccs_header(classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom homepage url'" do
      let(:fixture_name) { 'custom homepage url' }
      let(:result) { ccs_header(homepage_url: fixture_options[:homepageUrl]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with GCA branding'" do
      let(:fixture_name) { 'with GCA branding' }
      let(:result) { ccs_header(use_gca_branding: fixture_options[:useGcaBranding]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
