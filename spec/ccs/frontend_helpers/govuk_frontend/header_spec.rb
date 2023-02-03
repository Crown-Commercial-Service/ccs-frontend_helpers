# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/header'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Header, type: :helper do
  include described_class

  let(:header_element) { Capybara::Node::Simple.new(result).find('header.govuk-header') }
  let(:header_container_element) { Capybara::Node::Simple.new(result).find('div.govuk-header__container') }
  let(:header_content_element) { Capybara::Node::Simple.new(result).find('div.govuk-header__content') }
  let(:header_navigation_element) { Capybara::Node::Simple.new(result).find('nav.govuk-header__navigation') }
  let(:menu_button) { header_content_element.find('button.govuk-header__menu-button', visible: :hidden) }
  let(:navigation_item_element) { header_navigation_element.first('a.govuk-header__link') }

  describe '.govuk_header' do
    let(:result) { govuk_header(**header_options) }

    let(:header_options) do
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
    let(:options) { { homepage_url: 'https://www.crowncommercial.gov.uk/' } }

    let(:default_html) do
      '
        <header class="govuk-header" data-module="govuk-header" role="banner">
          <div class="govuk-header__container govuk-width-container">
            <div class="govuk-header__logo">
              <a class="govuk-header__link govuk-header__link--homepage" href="https://www.crowncommercial.gov.uk/">
                <span class="govuk-header__logotype">
                  <svg class="govuk-header__logotype-crown" xmlns="http://www.w3.org/2000/svg" height="30" width="36" aria-hidden="true" focusable="false" viewbox="0 0 132 97">
                    <path fill="currentColor" fill-rule="evenodd" d="M25 30.2c3.5 1.5 7.7-.2 9.1-3.7 1.5-3.6-.2-7.8-3.9-9.2-3.6-1.4-7.6.3-9.1 3.9-1.4 3.5.3 7.5 3.9 9zM9 39.5c3.6 1.5 7.8-.2 9.2-3.7 1.5-3.6-.2-7.8-3.9-9.1-3.6-1.5-7.6.2-9.1 3.8-1.4 3.5.3 7.5 3.8 9zM4.4 57.2c3.5 1.5 7.7-.2 9.1-3.8 1.5-3.6-.2-7.7-3.9-9.1-3.5-1.5-7.6.3-9.1 3.8-1.4 3.5.3 7.6 3.9 9.1zm38.3-21.4c3.5 1.5 7.7-.2 9.1-3.8 1.5-3.6-.2-7.7-3.9-9.1-3.6-1.5-7.6.3-9.1 3.8-1.3 3.6.4 7.7 3.9 9.1zm64.4-5.6c-3.6 1.5-7.8-.2-9.1-3.7-1.5-3.6.2-7.8 3.8-9.2 3.6-1.4 7.7.3 9.2 3.9 1.3 3.5-.4 7.5-3.9 9zm15.9 9.3c-3.6 1.5-7.7-.2-9.1-3.7-1.5-3.6.2-7.8 3.7-9.1 3.6-1.5 7.7.2 9.2 3.8 1.5 3.5-.3 7.5-3.8 9zm4.7 17.7c-3.6 1.5-7.8-.2-9.2-3.8-1.5-3.6.2-7.7 3.9-9.1 3.6-1.5 7.7.3 9.2 3.8 1.3 3.5-.4 7.6-3.9 9.1zM89.3 35.8c-3.6 1.5-7.8-.2-9.2-3.8-1.4-3.6.2-7.7 3.9-9.1 3.6-1.5 7.7.3 9.2 3.8 1.4 3.6-.3 7.7-3.9 9.1zM69.7 17.7l8.9 4.7V9.3l-8.9 2.8c-.2-.3-.5-.6-.9-.9L72.4 0H59.6l3.5 11.2c-.3.3-.6.5-.9.9l-8.8-2.8v13.1l8.8-4.7c.3.3.6.7.9.9l-5 15.4v.1c-.2.8-.4 1.6-.4 2.4 0 4.1 3.1 7.5 7 8.1h.2c.3 0 .7.1 1 .1.4 0 .7 0 1-.1h.2c4-.6 7.1-4.1 7.1-8.1 0-.8-.1-1.7-.4-2.4V34l-5.1-15.4c.4-.2.7-.6 1-.9zM66 92.8c16.9 0 32.8 1.1 47.1 3.2 4-16.9 8.9-26.7 14-33.5l-9.6-3.4c1 4.9 1.1 7.2 0 10.2-1.5-1.4-3-4.3-4.2-8.7L108.6 76c2.8-2 5-3.2 7.5-3.3-4.4 9.4-10 11.9-13.6 11.2-4.3-.8-6.3-4.6-5.6-7.9 1-4.7 5.7-5.9 8-.5 4.3-8.7-3-11.4-7.6-8.8 7.1-7.2 7.9-13.5 2.1-21.1-8 6.1-8.1 12.3-4.5 20.8-4.7-5.4-12.1-2.5-9.5 6.2 3.4-5.2 7.9-2 7.2 3.1-.6 4.3-6.4 7.8-13.5 7.2-10.3-.9-10.9-8-11.2-13.8 2.5-.5 7.1 1.8 11 7.3L80.2 60c-4.1 4.4-8 5.3-12.3 5.4 1.4-4.4 8-11.6 8-11.6H55.5s6.4 7.2 7.9 11.6c-4.2-.1-8-1-12.3-5.4l1.4 16.4c3.9-5.5 8.5-7.7 10.9-7.3-.3 5.8-.9 12.8-11.1 13.8-7.2.6-12.9-2.9-13.5-7.2-.7-5 3.8-8.3 7.1-3.1 2.7-8.7-4.6-11.6-9.4-6.2 3.7-8.5 3.6-14.7-4.6-20.8-5.8 7.6-5 13.9 2.2 21.1-4.7-2.6-11.9.1-7.7 8.8 2.3-5.5 7.1-4.2 8.1.5.7 3.3-1.3 7.1-5.7 7.9-3.5.7-9-1.8-13.5-11.2 2.5.1 4.7 1.3 7.5 3.3l-4.7-15.4c-1.2 4.4-2.7 7.2-4.3 8.7-1.1-3-.9-5.3 0-10.2l-9.5 3.4c5 6.9 9.9 16.7 14 33.5 14.8-2.1 30.8-3.2 47.7-3.2z"></path>
                  </svg>
                  <span class="govuk-header__logotype-text">
                    GOV.UK
                  </span>
                </span>
              </a>
            </div>
            <div class="govuk-header__content">
              <span class="govuk-header__service-name">
                U.A. High
              </span>
              <nav aria-label="Menu" class="govuk-header__navigation">
                <button name="button" type="button" class="govuk-header__menu-button govuk-js-header-toggle" aria-controls="navigation" aria-label="Show or hide menu" hidden="hidden">
                  Menu
                </button>
                <ul id="navigation" class="govuk-header__navigation-list">
                  <li class="govuk-header__navigation-item">
                    <a class="govuk-header__link" href="/here">Here</a>
                  </li>
                  <li class="govuk-header__navigation-item">
                    <a class="govuk-header__link" href="/we">We</a>
                  </li>
                  <li class="govuk-header__navigation-item govuk-header__navigation-item--active">
                    go
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        </header>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the header' do
        expect(header_element.to_html).to eq(default_html)
      end
    end

    context 'when no service, naviagtion or container options are sent' do
      let(:result) { govuk_header }

      it 'correctly formats the HTML with the hint text' do
        expect(header_element.to_html).to eq('
          <header class="govuk-header" data-module="govuk-header" role="banner">
            <div class="govuk-header__container govuk-width-container">
              <div class="govuk-header__logo">
                <a class="govuk-header__link govuk-header__link--homepage" href="/">
                  <span class="govuk-header__logotype">
                    <svg class="govuk-header__logotype-crown" xmlns="http://www.w3.org/2000/svg" height="30" width="36" aria-hidden="true" focusable="false" viewbox="0 0 132 97">
                      <path fill="currentColor" fill-rule="evenodd" d="M25 30.2c3.5 1.5 7.7-.2 9.1-3.7 1.5-3.6-.2-7.8-3.9-9.2-3.6-1.4-7.6.3-9.1 3.9-1.4 3.5.3 7.5 3.9 9zM9 39.5c3.6 1.5 7.8-.2 9.2-3.7 1.5-3.6-.2-7.8-3.9-9.1-3.6-1.5-7.6.2-9.1 3.8-1.4 3.5.3 7.5 3.8 9zM4.4 57.2c3.5 1.5 7.7-.2 9.1-3.8 1.5-3.6-.2-7.7-3.9-9.1-3.5-1.5-7.6.3-9.1 3.8-1.4 3.5.3 7.6 3.9 9.1zm38.3-21.4c3.5 1.5 7.7-.2 9.1-3.8 1.5-3.6-.2-7.7-3.9-9.1-3.6-1.5-7.6.3-9.1 3.8-1.3 3.6.4 7.7 3.9 9.1zm64.4-5.6c-3.6 1.5-7.8-.2-9.1-3.7-1.5-3.6.2-7.8 3.8-9.2 3.6-1.4 7.7.3 9.2 3.9 1.3 3.5-.4 7.5-3.9 9zm15.9 9.3c-3.6 1.5-7.7-.2-9.1-3.7-1.5-3.6.2-7.8 3.7-9.1 3.6-1.5 7.7.2 9.2 3.8 1.5 3.5-.3 7.5-3.8 9zm4.7 17.7c-3.6 1.5-7.8-.2-9.2-3.8-1.5-3.6.2-7.7 3.9-9.1 3.6-1.5 7.7.3 9.2 3.8 1.3 3.5-.4 7.6-3.9 9.1zM89.3 35.8c-3.6 1.5-7.8-.2-9.2-3.8-1.4-3.6.2-7.7 3.9-9.1 3.6-1.5 7.7.3 9.2 3.8 1.4 3.6-.3 7.7-3.9 9.1zM69.7 17.7l8.9 4.7V9.3l-8.9 2.8c-.2-.3-.5-.6-.9-.9L72.4 0H59.6l3.5 11.2c-.3.3-.6.5-.9.9l-8.8-2.8v13.1l8.8-4.7c.3.3.6.7.9.9l-5 15.4v.1c-.2.8-.4 1.6-.4 2.4 0 4.1 3.1 7.5 7 8.1h.2c.3 0 .7.1 1 .1.4 0 .7 0 1-.1h.2c4-.6 7.1-4.1 7.1-8.1 0-.8-.1-1.7-.4-2.4V34l-5.1-15.4c.4-.2.7-.6 1-.9zM66 92.8c16.9 0 32.8 1.1 47.1 3.2 4-16.9 8.9-26.7 14-33.5l-9.6-3.4c1 4.9 1.1 7.2 0 10.2-1.5-1.4-3-4.3-4.2-8.7L108.6 76c2.8-2 5-3.2 7.5-3.3-4.4 9.4-10 11.9-13.6 11.2-4.3-.8-6.3-4.6-5.6-7.9 1-4.7 5.7-5.9 8-.5 4.3-8.7-3-11.4-7.6-8.8 7.1-7.2 7.9-13.5 2.1-21.1-8 6.1-8.1 12.3-4.5 20.8-4.7-5.4-12.1-2.5-9.5 6.2 3.4-5.2 7.9-2 7.2 3.1-.6 4.3-6.4 7.8-13.5 7.2-10.3-.9-10.9-8-11.2-13.8 2.5-.5 7.1 1.8 11 7.3L80.2 60c-4.1 4.4-8 5.3-12.3 5.4 1.4-4.4 8-11.6 8-11.6H55.5s6.4 7.2 7.9 11.6c-4.2-.1-8-1-12.3-5.4l1.4 16.4c3.9-5.5 8.5-7.7 10.9-7.3-.3 5.8-.9 12.8-11.1 13.8-7.2.6-12.9-2.9-13.5-7.2-.7-5 3.8-8.3 7.1-3.1 2.7-8.7-4.6-11.6-9.4-6.2 3.7-8.5 3.6-14.7-4.6-20.8-5.8 7.6-5 13.9 2.2 21.1-4.7-2.6-11.9.1-7.7 8.8 2.3-5.5 7.1-4.2 8.1.5.7 3.3-1.3 7.1-5.7 7.9-3.5.7-9-1.8-13.5-11.2 2.5.1 4.7 1.3 7.5 3.3l-4.7-15.4c-1.2 4.4-2.7 7.2-4.3 8.7-1.1-3-.9-5.3 0-10.2l-9.5 3.4c5 6.9 9.9 16.7 14 33.5 14.8-2.1 30.8-3.2 47.7-3.2z"></path>
                    </svg>
                    <span class="govuk-header__logotype-text">
                      GOV.UK
                    </span>
                  </span>
                </a>
              </div>
            </div>
          </header>
        '.to_one_line)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(header_element[:class]).to eq('govuk-header my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' }, test: 'General Kenobi' } } }

      it 'has the additional attributes' do
        expect(header_element[:'data-module']).to eq('govuk-header')
        expect(header_element[:'data-test']).to eq('hello there')
        expect(header_element[:test]).to eq('General Kenobi')
      end
    end

    context 'when custom container classes are passed' do
      let(:options) { { container_classes: 'govuk-header__container--full-width' } }

      it 'has the custom class' do
        expect(header_container_element[:class]).to eq('govuk-header__container govuk-header__container--full-width')
      end
    end

    context 'when there is a product name' do
      let(:options) { { product_name: 'Union of Aionios' } }

      it 'has the product name' do
        expect(header_container_element).to have_css('span.govuk-header__product-name', text: 'Union of Aionios')
      end
    end

    context 'when considering the serivce options' do
      context 'when there are no service options' do
        let(:header_options) do
          {
            navigation: navigation_options
          }.merge(options)
        end

        it 'does not render the service name' do
          expect(header_content_element).not_to have_css('.govuk-header__service-name')
        end
      end

      context 'when there is as service name' do
        it 'renders the service name' do
          expect(header_content_element).to have_css('span.govuk-header__service-name', text: 'U.A. High')
        end
      end

      context 'when a service name url is provided' do
        let(:service_options) { super().merge({ href: '/ua-high' }) }

        it 'renders the service name as a link' do
          expect(header_content_element).to have_css('a.govuk-header__link.govuk-header__service-name', text: 'U.A. High')
        end
      end
    end

    context 'when custom navigation classes are passed' do
      let(:navigation_options) { super().merge({ classes: 'govuk-header__navigation--end' }) }

      it 'has the custom class' do
        expect(header_navigation_element[:class]).to eq('govuk-header__navigation govuk-header__navigation--end')
      end
    end

    context 'when considering a navigation link item' do
      let(:navigation_options) do
        {
          items: [
            {
              text: 'Here',
              href: '/here'
            }.merge(navigation_item_options)
          ]
        }
      end

      context 'when there is a custom class' do
        let(:navigation_item_options) { { attributes: { class: 'my-custom-navigation-item-class' } } }

        it 'does not have the custom class' do
          expect(navigation_item_element[:class]).to eq('govuk-header__link')
        end
      end

      context 'when there are additional attributes' do
        let(:navigation_item_options) { { attributes: { id: 'my-custom-navigation-item-id', data: { test: 'hello there' } } } }

        it 'has the additional attributes' do
          expect(navigation_item_element[:id]).to eq('my-custom-navigation-item-id')
          expect(navigation_item_element[:'data-test']).to eq('hello there')
        end
      end
    end

    context 'when considering the menu button' do
      context 'and no custom menu text is passed' do
        it 'has the default menu button text' do
          expect(menu_button).to have_content('Menu')
        end
      end

      context 'and custom menu text is passed' do
        let(:options) { { menu_button: { text: 'This is the menu' } } }

        it 'has the custom menu button text' do
          expect(menu_button).to have_content('This is the menu')
        end
      end

      context 'and no custom menu label text is passed' do
        it 'has the default menu button text' do
          expect(menu_button[:'aria-label']).to eq 'Show or hide menu'
        end
      end

      context 'and custom menu label text is passed' do
        let(:options) { { menu_button: { label: 'This is the menu that you can show or hide' } } }

        it 'has the custom menu button text' do
          expect(menu_button[:'aria-label']).to eq 'This is the menu that you can show or hide'
        end
      end
    end
  end
end
