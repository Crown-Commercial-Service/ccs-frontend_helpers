# frozen_string_literal: true

require 'ccs/components/govuk/service_navigation/navigation'

RSpec.describe CCS::Components::GovUK::ServiceNavigation::Navigation do
  include_context 'and I have a view context'

  let(:navigation_section_element) { Capybara::Node::Simple.new(result).find('nav.govuk-service-navigation__wrapper') }
  let(:menu_button_element) { navigation_section_element.find('button.govuk-service-navigation__toggle', visible: :hidden) }

  describe '.render' do
    let(:govuk_service_navigation_navigation) { described_class.new(navigation: navigation, menu_button: menu_button, context: view_context) }
    let(:result) { govuk_service_navigation_navigation.render }

    let(:navigation) do
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
      }.merge(navigation_options)
    end
    let(:menu_button) { nil }
    let(:navigation_options) { {} }

    let(:default_html) do
      '
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
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the header navigation' do
        expect(navigation_section_element.to_html).to eq(default_html)
      end
    end

    context 'when no service, naviagtion or container options are sent' do
      let(:govuk_service_navigation_navigation) { described_class.new(navigation: navigation, context: view_context) }

      it 'correctly formats the HTML for the header navigation' do
        expect(navigation_section_element.to_html).to eq(default_html)
      end
    end

    context 'when custom navigation classes are passed' do
      let(:navigation_options) { { classes: 'custom-navigation-class' } }

      it 'has the custom class' do
        expect(navigation_section_element[:class]).to eq('govuk-service-navigation__wrapper custom-navigation-class')
      end
    end

    context 'when a custom navigation id is passed' do
      let(:navigation_options) { { id: 'main-navigation' } }

      it 'has the custom id and controls the custom id' do
        expect(navigation_section_element.find('ul.govuk-service-navigation__list')[:id]).to eq('main-navigation')
        expect(menu_button_element[:'aria-controls']).to eq('main-navigation')
      end
    end

    context 'when custom navigation label are passed' do
      let(:navigation_options) { { label: 'Say hello to the menu' } }

      it 'has the custom aria label' do
        expect(navigation_section_element[:'aria-label']).to eq('Say hello to the menu')
      end
    end

    context 'when considering the menu button' do
      context 'and custom menu text is passed' do
        let(:menu_button) { { text: 'This is the menu' } }

        it 'has the custom menu button text' do
          expect(menu_button_element).to have_content('This is the menu')
        end
      end

      context 'and custom menu label text is passed' do
        let(:menu_button) { { label: 'This is the menu that you can show or hide' } }

        it 'has the custom menu button text' do
          expect(menu_button_element[:'aria-label']).to eq 'This is the menu that you can show or hide'
        end
      end
    end
  end
end
