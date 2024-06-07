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
  end
end
