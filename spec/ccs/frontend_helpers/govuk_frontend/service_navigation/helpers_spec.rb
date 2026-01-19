# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/service_navigation'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ServiceNavigation, '#helpers', type: :helper do
  include described_class

  let(:service_navigation_element) { Capybara::Node::Simple.new(result).find('.govuk-service-navigation') }

  describe '.govuk_service_navigation' do
    let(:result) { govuk_service_navigation(**service_navigation_options) }

    let(:service_navigation_options) do
      {
        navigation: {
          items: [
            {
              href: '#/1',
              text: 'Navigation item 1'
            },
            {
              href: '#/2',
              text: 'Navigation item 2',
              current: true
            },
            {
              href: '#/3',
              text: 'Navigation item 3'
            },
            {
              href: '#/4',
              text: 'Navigation item 4'
            }
          ]
        },
      }
    end

    let(:default_html) do
      '
        <div class="govuk-service-navigation" data-module="govuk-service-navigation">
          <div class="govuk-width-container">
            <div class="govuk-service-navigation__container">
              <nav aria-label="Menu" class="govuk-service-navigation__wrapper">
                <button name="button" type="button" class="govuk-service-navigation__toggle govuk-js-service-navigation-toggle" aria-controls="navigation" aria-hidden="true" hidden="hidden">
                  Menu
                </button>
                <ul id="navigation" class="govuk-service-navigation__list">
                  <li class="govuk-service-navigation__item">
                    <a class="govuk-service-navigation__link" href="#/1">
                      Navigation item 1
                    </a>
                  </li>
                  <li class="govuk-service-navigation__item govuk-service-navigation__item--active">
                    <a aria-current="page" class="govuk-service-navigation__link" href="#/2">
                      <strong class="govuk-service-navigation__active-fallback">
                        Navigation item 2
                      </strong>
                    </a>
                  </li>
                  <li class="govuk-service-navigation__item">
                    <a class="govuk-service-navigation__link" href="#/3">
                      Navigation item 3
                    </a>
                  </li>
                  <li class="govuk-service-navigation__item">
                    <a class="govuk-service-navigation__link" href="#/4">
                      Navigation item 4
                    </a>
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the header' do
        expect(service_navigation_element.to_html).to eq(default_html)
      end
    end

    context 'when no service or naviagtion options are sent' do
      let(:result) { govuk_service_navigation }

      it 'correctly formats the HTML with the hint text' do
        expect(service_navigation_element.to_html).to eq('
          <div class="govuk-service-navigation" data-module="govuk-service-navigation">
            <div class="govuk-width-container">
              <div class="govuk-service-navigation__container"></div>
            </div>
          </div>
        '.to_one_line)
      end
    end
  end
end
