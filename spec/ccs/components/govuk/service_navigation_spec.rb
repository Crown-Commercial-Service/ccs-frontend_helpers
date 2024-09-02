# frozen_string_literal: true

require 'ccs/components/govuk/service_navigation'

RSpec.describe CCS::Components::GovUK::ServiceNavigation do
  include_context 'and I have a view context'

  let(:service_navigation_element) { Capybara::Node::Simple.new(result).find('.govuk-service-navigation') }
  let(:service_navigation_content_element) { Capybara::Node::Simple.new(result).find('div.govuk-service-navigation__container') }

  describe '.render' do
    let(:govuk_service_navigation) { described_class.new(context: view_context, **service_navigation_options) }
    let(:result) { govuk_service_navigation.render }

    let(:service_navigation_options) do
      {
        service: service_options,
        navigation: navigation_options
      }.merge(options)
    end

    let(:service_options) do
      {
        name: 'U.A. High'
      }
    end
    let(:navigation_options) do
      {
        items: [
          {
            text: 'Here',
            href: '/here'
          },
          {
            text: 'We',
            href: '/we'
          },
          {
            text: 'go',
            active: true
          }
        ]
      }
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <section class="govuk-service-navigation" data-module="govuk-service-navigation" aria-label="Service information">
          <div class="govuk-width-container">
            <div class="govuk-service-navigation__container">
              <span class="govuk-service-navigation__service-name">
                <span class="govuk-service-navigation__text">U.A. High</span>
              </span>
              <nav aria-label="Menu" class="govuk-service-navigation__wrapper">
                <button name="button" type="button" class="govuk-service-navigation__toggle govuk-js-service-navigation-toggle" aria-controls="navigation" hidden="hidden">
                  Menu
                </button>
                <ul id="navigation" class="govuk-service-navigation__list">
                  <li class="govuk-service-navigation__item">
                    <a class="govuk-service-navigation__link" href="/here">Here</a>
                  </li>
                  <li class="govuk-service-navigation__item">
                    <a class="govuk-service-navigation__link" href="/we">We</a>
                  </li>
                  <li class="govuk-service-navigation__item govuk-service-navigation__item--active">
                    <span aria-current="true" class="govuk-service-navigation__text">
                      <strong class="govuk-service-navigation__active-fallback">go</strong>
                    </span>
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        </section>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the header' do
        expect(service_navigation_element.to_html).to eq(default_html)
      end
    end

    context 'when no service, naviagtion or container options are sent' do
      let(:govuk_service_navigation) { described_class.new(context: view_context) }

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

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(service_navigation_element[:class]).to eq('govuk-service-navigation my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' }, test: 'General Kenobi' } } }

      it 'has the additional attributes' do
        expect(service_navigation_element[:'data-module']).to eq('govuk-service-navigation')
        expect(service_navigation_element[:'data-test']).to eq('hello there')
        expect(service_navigation_element[:test]).to eq('General Kenobi')
      end
    end

    context 'when considering the serivce options' do
      context 'when there are no service options' do
        let(:service_navigation_options) do
          {
            navigation: navigation_options
          }.merge(options)
        end

        it 'does not render the service name' do
          expect(service_navigation_content_element).to have_no_css('.govuk-service-navigation__service-name')
        end
      end

      context 'when there is as service name' do
        it 'renders the service name' do
          expect(service_navigation_content_element).to have_css('span.govuk-service-navigation__service-name', text: 'U.A. High')
        end
      end

      context 'when a service name url is provided' do
        let(:service_options) { super().merge({ href: '/ua-high' }) }

        it 'renders the service name as a link' do
          expect(service_navigation_content_element).to have_css('span.govuk-service-navigation__service-name > a.govuk-service-navigation__link', text: 'U.A. High')
        end
      end
    end
  end
end
