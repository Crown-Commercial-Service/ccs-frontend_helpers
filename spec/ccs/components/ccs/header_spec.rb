# frozen_string_literal: true

require 'ccs/components/ccs/header'

RSpec.describe CCS::Components::CCS::Header, type: :helper do
  include_context 'and I have a view context'
  include_context 'and I have created the CCS logo HTML'

  let(:header_element) { Capybara::Node::Simple.new(result).find('header.ccs-header') }
  let(:header_container_element) { header_element.find('div.ccs-header__container') }
  let(:header_content_element) { header_element.find('div.ccs-header__content') }
  let(:service_authentication_item_element) { header_element.first('div.ccs-header__service-authentication a.ccs-header__link') }
  let(:header_navigation_element) { header_element.find('nav.ccs-header__navigation') }
  let(:menu_button) { header_content_element.find('button.ccs-header__menu-button', visible: :hidden) }
  let(:primary_navigation_item_element) { header_navigation_element.first('#navigation-primary a.ccs-header__link') }
  let(:secondary_navigation_item_element) { header_navigation_element.first('#navigation-secondary a.ccs-header__link') }

  describe '.render' do
    let(:ccs_header) { described_class.new(context: view_context, **header_options) }
    let(:result) { ccs_header.render }

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
      let(:ccs_header) { described_class.new(context: view_context) }

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

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(header_element[:class]).to eq('ccs-header my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' }, test: 'General Kenobi' } } }

      it 'has the additional attributes' do
        expect(header_element[:'data-module']).to eq('ccs-header')
        expect(header_element[:'data-test']).to eq('hello there')
        expect(header_element[:test]).to eq('General Kenobi')
      end
    end

    context 'when custom container classes are passed' do
      let(:options) { { container_classes: 'ccs-header__container--full-width' } }

      it 'has the custom class' do
        expect(header_container_element[:class]).to eq('ccs-header__container ccs-header__container--full-width')
      end
    end

    context 'when considering the serivce options' do
      context 'when there are no service options' do
        let(:header_options) do
          {
            service_authentication_items: service_authentication,
            navigation: navigation_options,
          }.merge(options)
        end

        it 'does not render the service name' do
          expect(header_content_element).to have_no_css('.ccs-header__service-name')
        end
      end

      context 'when there is as service name' do
        it 'renders the service name' do
          expect(header_content_element).to have_css('span.ccs-header__link--service-name', text: 'U.A. High')
        end
      end

      context 'when a service name url is provided' do
        let(:service_options) { super().merge({ href: '/ua-high' }) }

        it 'renders the service name as a link' do
          expect(header_content_element).to have_css('a.ccs-header__link.ccs-header__link--service-name', text: 'U.A. High')
        end
      end
    end
  end
end
