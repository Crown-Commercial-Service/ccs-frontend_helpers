# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/logo'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Logo, '#fixtures', type: :helper do
  include described_class

  describe '.ccs_logo from fixtures' do
    include_context 'and I have loaded the CCS Frontend fixture'

    let(:component_name) { 'logo' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { ccs_logo }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with crown only'" do
      let(:fixture_name) { 'with crown only' }
      let(:result) { ccs_logo(show_only_crown: fixture_options[:showOnlyCrown]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'use GCA branding'" do
      let(:fixture_name) { 'use GCA branding' }
      let(:result) { ccs_logo(use_gca_branding: fixture_options[:useGcaBranding]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
