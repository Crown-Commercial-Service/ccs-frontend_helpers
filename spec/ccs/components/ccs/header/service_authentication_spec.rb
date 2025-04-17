# frozen_string_literal: true

require 'ccs/components/ccs/header/service_authentication'

RSpec.describe CCS::Components::CCS::Header::ServiceAuthentication do
  include_context 'and I have a view context'

  let(:header_service_authentication_section_element) { Capybara::Node::Simple.new(result).find('div.ccs-header__service-authentication') }

  describe '.render' do
    let(:ccs_footer_navigation) { described_class.new(service_authentication_items: service_authentication_links, container_classes: container_classes, context: view_context) }
    let(:result) { ccs_footer_navigation.render }

    let(:service_authentication_links) do
      [
        {
          text: 'Sign in'
        },
        {
          text: 'Sign out',
          href: '/sign-out'
        }
      ]
    end
    let(:container_classes) { nil }

    it 'correctly formats the HTML for the header service authentication section' do
      expect(header_service_authentication_section_element.to_html).to eq('
        <div class="ccs-header__service-authentication">
          <div class="ccs-header__service-authentication-container">
            <ul class="ccs-header__service-authentication-list">
              <li class="ccs-header__service-authentication-item">
                Sign in
              </li>
              <li class="ccs-header__service-authentication-item">
                <a class="ccs-header__link" href="/sign-out">
                  Sign out
                </a>
              </li>
            </ul>
          </div>
        </div>
      '.to_one_line)
    end

    context 'when there is a container class' do
      let(:container_classes) { 'ccs-header__container--full-width' }

      it 'correctly formats the HTML with the container class' do
        expect(header_service_authentication_section_element.to_html).to eq('
          <div class="ccs-header__service-authentication">
            <div class="ccs-header__service-authentication-container ccs-header__container--full-width">
              <ul class="ccs-header__service-authentication-list">
                <li class="ccs-header__service-authentication-item">
                  Sign in
                </li>
                <li class="ccs-header__service-authentication-item">
                  <a class="ccs-header__link" href="/sign-out">
                    Sign out
                  </a>
                </li>
              </ul>
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'and there are HTTP methods in the authentication items' do
      let(:service_authentication_links) do
        [
          {
            text: 'Sign in',
            href: '/sign-in',
            method: :put
          },
          {
            text: 'Sign out',
            href: '/sign-out',
            method: :delete
          }
        ]
      end

      it 'renders the links as buttons' do
        expect(header_service_authentication_section_element.to_html).to eq('
          <div class="ccs-header__service-authentication">
            <div class="ccs-header__service-authentication-container">
              <ul class="ccs-header__service-authentication-list">
                <li class="ccs-header__service-authentication-item">
                  <form class="button_to" method="post" action="/sign-in">
                    <input type="hidden" name="_method" value="put" autocomplete="off">
                    <button class="ccs-header__button_as_link" type="submit">
                      Sign in
                    </button>
                  </form>
                </li>
                <li class="ccs-header__service-authentication-item">
                  <form class="button_to" method="post" action="/sign-out">
                    <input type="hidden" name="_method" value="delete" autocomplete="off">
                    <button class="ccs-header__button_as_link" type="submit">
                      Sign out
                    </button>
                  </form>
                </li>
              </ul>
            </div>
          </div>
        '.to_one_line)
      end
    end
  end
end
