# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/logo'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Logo, '#helpers', type: :helper do
  include described_class

  include_context 'and I have created the CCS logo HTML'

  let(:logo_element) { Capybara::Node::Simple.new(result).find('span.ccs-logo') }

  describe '.ccs_logo' do
    let(:result) { ccs_logo }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the logo' do
        expect(logo_element.to_html).to eq(ccs_logo_html)
      end
    end
  end
end
