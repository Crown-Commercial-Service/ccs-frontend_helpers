# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/header'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Header, '#helpers', type: :helper do
  include described_class

  include_context 'and I have created the CCS logo HTML'

  let(:header_element) { Capybara::Node::Simple.new(result).find('header.ccs-header') }

  describe '.ccs_header' do
    let(:result) { ccs_header(**options) }

    let(:options) { { homepage_url: 'https://www.crowncommercial.gov.uk/my-hero-academia' } }

    let(:default_html) do
      "
        <header class=\"ccs-header\" data-module=\"ccs-header\">
          <div class=\"ccs-header__container govuk-width-container\">
            <div class=\"ccs-header__logo\">
              <a class=\"ccs-header__link ccs-header__link--homepage\" aria-label=\"Crown Commercial Service\" href=\"https://www.crowncommercial.gov.uk/my-hero-academia\">
                #{ccs_logo_html}
              </a>
            </div>
          </div>
        </header>
      ".to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the header' do
        expect(header_element.to_html).to eq(default_html)
      end
    end

    context 'when no service, naviagtion or container options are sent' do
      let(:result) { ccs_header }

      it 'correctly formats the HTML with the hint text' do
        expect(header_element.to_html).to eq("
          <header class=\"ccs-header\" data-module=\"ccs-header\">
            <div class=\"ccs-header__container govuk-width-container\">
              <div class=\"ccs-header__logo\">
                <a class=\"ccs-header__link ccs-header__link--homepage\" aria-label=\"Crown Commercial Service\" href=\"https://www.crowncommercial.gov.uk\">
                  #{ccs_logo_html}
                </a>
              </div>
            </div>
          </header>
        ".to_one_line)
      end
    end

    context 'when using the GCA branding' do
      let(:result) { ccs_header(use_gca_branding: true) }

      it 'correctly formats the HTML for the logo' do
        expect(header_element.to_html).to eq("
          <header class=\"ccs-header\" data-module=\"ccs-header\">
            <div class=\"ccs-header__container govuk-width-container\">
              <div class=\"ccs-header__logo\">
                <a class=\"ccs-header__link ccs-header__link--homepage\" aria-label=\"Crown Commercial Service\" href=\"https://www.gca.gov.uk\">
                  #{gca_logo_html}
                </a>
              </div>
            </div>
          </header>
        ".to_one_line)
      end
    end
  end
end
