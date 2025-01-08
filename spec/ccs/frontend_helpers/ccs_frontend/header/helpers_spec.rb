# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/header'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Header, '#helpers', type: :helper do
  include described_class

  include_context 'and I have created the CCS logo HTML'

  let(:header_element) { Capybara::Node::Simple.new(result).find('header.ccs-header') }

  describe '.ccs_header' do
    let(:result) { ccs_header(**header_options) }

    let(:header_options) do
      {
        service_authentication_items: service_authentication,
        service: service_options,
        navigation: navigation_options,
      }.merge(options)
    end

    let(:service_authentication) do
      [
        {
          text: 'Sign out',
          href: '/sign-out'
        }
      ]
    end
    let(:service_options) do
      {
        name: 'U.A. High'
      }
    end
    let(:navigation_options) do
      {
        primary_items: [
          {
            text: 'Go',
            href: '/go'
          },
          {
            text: 'Beyond',
            active: true
          },
        ],
        secondary_items: [
          {
            text: 'Plus',
            href: '/plus'
          },
          {
            text: 'Ultra!',
            href: '/ultra'
          },
        ]
      }
    end
    let(:options) { { homepage_url: 'https://www.crowncommercial.gov.uk/my-hero-academia' } }

    let(:default_html) do
      "
        <header class=\"ccs-header\" data-module=\"ccs-header\">
          <div class=\"ccs-header__service-authentication\">
            <div class=\"ccs-header__service-authentication-container govuk-width-container\">
              <ul class=\"ccs-header__service-authentication-list\">
                <li class=\"ccs-header__service-authentication-item\">
                  <a class=\"ccs-header__link\" href=\"/sign-out\">
                    Sign out
                  </a><
                /li>
              </ul>
            </div>
          </div>
          <div class=\"ccs-header__container govuk-width-container\">
            <div class=\"ccs-header__logo\">
              <a class=\"ccs-header__link ccs-header__link--homepage\" aria-label=\"Crown Commercial Service\" href=\"https://www.crowncommercial.gov.uk/my-hero-academia\">
                #{ccs_logo_html}
              </a>
            </div>
            <div class=\"ccs-header__content\">
              <span class=\"ccs-header__link--service-name\">
                U.A. High
              </span>
              <nav aria-label=\"Menu\" class=\"ccs-header__navigation\">
                <button name=\"button\" type=\"button\" class=\"ccs-header__menu-button ccs-js-header-toggle\" aria-controls=\"navigation\" aria-label=\"Show or hide menu\" hidden=\"hidden\">
                  Menu
                </button>
                <div id=\"navigation\" class=\"ccs-header__navigation-lists\">
                  <ul id=\"navigation-secondary\" class=\"ccs-header__navigation-secondary-list\">
                    <li class=\"ccs-header__navigation-item\">
                      <a class=\"ccs-header__link\" href=\"/plus\">
                        Plus
                      </a>
                    </li>
                    <li class=\"ccs-header__navigation-item\">
                      <a class=\"ccs-header__link\" href=\"/ultra\">
                        Ultra!
                      </a>
                    </li>
                  </ul>
                  <ul id=\"navigation-primary\" class=\"ccs-header__navigation-primary-list\">
                    <li class=\"ccs-header__navigation-item\">
                      <a class=\"ccs-header__link\" href=\"/go\">
                        Go
                      </a>
                    </li>
                    <li class=\"ccs-header__navigation-item ccs-header__navigation-item--active\">
                      Beyond
                    </li>
                  </ul>
                </div>
              </nav>
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
  end
end
