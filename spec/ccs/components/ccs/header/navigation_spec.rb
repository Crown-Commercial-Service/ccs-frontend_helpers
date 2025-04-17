# frozen_string_literal: true

require 'ccs/components/ccs/header/navigation'

RSpec.describe CCS::Components::CCS::Header::Navigation do
  include_context 'and I have a view context'

  let(:navigation_section_element) { Capybara::Node::Simple.new(result).find('nav.ccs-header__navigation') }
  let(:menu_button_element) { navigation_section_element.find('button.ccs-header__menu-button', visible: :hidden) }

  describe '.render' do
    let(:ccs_header_navigation) { described_class.new(navigation: navigation, serivce_name_present: serivce_name_present, menu_button: menu_button, context: view_context) }
    let(:result) { ccs_header_navigation.render }

    let(:navigation) do
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
      }.merge(navigation_options)
    end
    let(:serivce_name_present) { true }
    let(:menu_button) { nil }
    let(:navigation_options) { {} }

    let(:default_html) do
      '
        <nav aria-label="Menu" class="ccs-header__navigation">
          <button name="button" type="button" class="ccs-header__menu-button ccs-js-header-toggle" aria-controls="navigation" aria-label="Show or hide menu" hidden="hidden">
            Menu
          </button>
          <div id="navigation" class="ccs-header__navigation-lists">
            <ul id="navigation-secondary" class="ccs-header__navigation-secondary-list">
              <li class="ccs-header__navigation-item">
                <a class="ccs-header__link" href="/plus">
                  Plus
                </a>
              </li>
              <li class="ccs-header__navigation-item">
                <a class="ccs-header__link" href="/ultra">
                  Ultra!
                </a>
              </li>
            </ul>
            <ul id="navigation-primary" class="ccs-header__navigation-primary-list">
              <li class="ccs-header__navigation-item">
                <a class="ccs-header__link" href="/go">
                  Go
                </a>
              </li>
              <li class="ccs-header__navigation-item ccs-header__navigation-item--active">
                Beyond
              </li>
            </ul>
          </div>
        </nav>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the header navigation' do
        expect(navigation_section_element.to_html).to eq(default_html)
      end
    end

    context 'when no menu button options are sent' do
      let(:ccs_header_navigation) { described_class.new(navigation: navigation, serivce_name_present: serivce_name_present, context: view_context) }

      it 'correctly formats the HTML for the header navigation' do
        expect(navigation_section_element.to_html).to eq(default_html)
      end
    end

    context 'when custom navigation classes are passed' do
      let(:navigation_options) { { classes: 'ccs-header__navigation--end' } }

      it 'has the custom class' do
        expect(navigation_section_element[:class]).to eq('ccs-header__navigation ccs-header__navigation--end')
      end
    end

    context 'when custom navigation label are passed' do
      let(:navigation_options) { { label: 'Say hello to the menu' } }

      it 'has the custom aria label' do
        expect(navigation_section_element[:'aria-label']).to eq('Say hello to the menu')
      end
    end

    context 'and there is no service name' do
      let(:serivce_name_present) { false }

      it 'has the no service name class' do
        expect(navigation_section_element[:class]).to eq('ccs-header__navigation ccs-header__navigation--no-service-name')
      end
    end

    context 'and there are HTTP methods in the navigation items' do
      let(:navigation) do
        {
          primary_items: [
            {
              text: 'Go',
              href: '/go',
              method: :post
            },
            {
              text: 'Beyond',
              active: true
            },
          ],
          secondary_items: [
            {
              text: 'Plus',
              href: '/plus',
              method: :patch
            },
            {
              text: 'Ultra!',
              href: '/ultra'
            },
          ]
        }.merge(navigation_options)
      end

      it 'renders the links as buttons' do
        expect(navigation_section_element.to_html).to eq('
          <nav aria-label="Menu" class="ccs-header__navigation">
            <button name="button" type="button" class="ccs-header__menu-button ccs-js-header-toggle" aria-controls="navigation" aria-label="Show or hide menu" hidden="hidden">
              Menu
            </button>
            <div id="navigation" class="ccs-header__navigation-lists">
              <ul id="navigation-secondary" class="ccs-header__navigation-secondary-list">
                <li class="ccs-header__navigation-item">
                  <form class="button_to" method="post" action="/plus">
                    <input type="hidden" name="_method" value="patch" autocomplete="off">
                    <button class="ccs-header__button_as_link" type="submit">
                      Plus
                    </button>
                  </form>
                </li>
                <li class="ccs-header__navigation-item">
                  <a class="ccs-header__link" href="/ultra">
                    Ultra!
                  </a>
                </li>
              </ul>
              <ul id="navigation-primary" class="ccs-header__navigation-primary-list">
                <li class="ccs-header__navigation-item">
                  <form class="button_to" method="post" action="/go">
                    <button class="ccs-header__button_as_link" type="submit">
                      Go
                    </button>
                  </form>
                </li>
                <li class="ccs-header__navigation-item ccs-header__navigation-item--active">
                  Beyond
                </li>
              </ul>
            </div>
          </nav>
        '.to_one_line)
      end
    end

    context 'and there is only primary navigation' do
      let(:navigation) do
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
          ]
        }
      end

      it 'has the no second list class' do
        expect(navigation_section_element).to have_css('ul#navigation-primary.ccs-header__navigation-primary-list.ccs-header__navigation--no-second-list')
      end

      it 'does not have the secondary navigation section' do
        expect(navigation_section_element).to have_no_css('ul#navigation-secondary')
      end
    end

    context 'and there is only secondary navigation' do
      let(:navigation) do
        {
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

      it 'has the no second list class' do
        expect(navigation_section_element).to have_css('ul#navigation-secondary.ccs-header__navigation-secondary-list.ccs-header__navigation--no-second-list')
      end

      it 'does not have the primary navigation section' do
        expect(navigation_section_element).to have_no_css('ul#navigation-primary')
      end
    end

    context 'and there is both primary abd secondary navigation' do
      it 'has the both sections' do
        expect(navigation_section_element).to have_css('ul#navigation-primary')
        expect(navigation_section_element).to have_css('ul#navigation-secondary')
      end

      it 'does not have the no second list class' do
        expect(navigation_section_element).to have_no_css('ul#navigation-secondary.ccs-header__navigation-secondary-list.ccs-header__navigation--no-second-list')
        expect(navigation_section_element).to have_no_css('ul#navigation-primary.ccs-header__navigation-primary-list.ccs-header__navigation--no-second-list')
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
