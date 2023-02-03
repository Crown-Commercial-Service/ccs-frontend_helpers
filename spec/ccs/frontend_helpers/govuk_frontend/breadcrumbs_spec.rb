# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/breadcrumbs'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Breadcrumbs, type: :helper do
  include described_class

  describe '.govuk_breadcrumbs' do
    let(:result) { govuk_breadcrumbs(items, **options) }

    let(:items) do
      [
        { text: 'Menu', href: '/menu' },
        { text: 'Map', href: '/menu/map' },
        { text: 'Swordmarch' }
      ]
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-breadcrumbs">
          <ol class="govuk-breadcrumbs__list">
            <li class="govuk-breadcrumbs__list-item">
              <a class="govuk-breadcrumbs__link" href="/menu">
                Menu
              </a>
            </li>
            <li class="govuk-breadcrumbs__list-item">
              <a class="govuk-breadcrumbs__link" href="/menu/map">
                Map
              </a>
            </li>
            <li class="govuk-breadcrumbs__list-item" aria-current="page">
              Swordmarch
            </li>
          </ol>
        </div>
      '.to_one_line
    end

    let(:breadcrumbs_element) { Capybara::Node::Simple.new(result).find('div.govuk-breadcrumbs') }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the text and content' do
        expect(breadcrumbs_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_breadcrumbs(items) }

      it 'correctly formats the HTML with the text and content' do
        expect(breadcrumbs_element.to_html).to eq(default_html)
      end
    end

    context 'when applying options to the breadcrumbs as a whole' do
      context 'when custom attributes are sent' do
        let(:options) { { attributes: { id: 'my-navigation', role: 'navigation' } } }

        it 'has the additional attributes' do
          expect(breadcrumbs_element[:id]).to eq('my-navigation')
          expect(breadcrumbs_element[:role]).to eq('navigation')
        end
      end

      context 'when additional classes are passed' do
        let(:options) { { classes: 'my-custom-class' } }

        it 'has the custom class' do
          expect(breadcrumbs_element[:class]).to eq('govuk-breadcrumbs my-custom-class')
        end
      end

      context 'when the collapse_on_mobile is true' do
        let(:options) { { collapse_on_mobile: true } }

        it 'has govuk-breadcrumbs--collapse-on-mobile class listed' do
          expect(breadcrumbs_element[:class]).to eq('govuk-breadcrumbs govuk-breadcrumbs--collapse-on-mobile')
        end
      end
    end
  end

  describe '.govuk_breadcrumb_link' do
    let(:result) { govuk_breadcrumb_link(item) }

    let(:breadcrumb_link_element) { Capybara::Node::Simple.new(result).find('li.govuk-breadcrumbs__list-item') }

    context 'when the text and link are passed' do
      let(:item) { { text: 'Menu', href: '/menu' } }

      it 'correctly formats the HTML with the link inside the list element' do
        expect(breadcrumb_link_element.to_html).to eq('
          <li class="govuk-breadcrumbs__list-item">
            <a class="govuk-breadcrumbs__link" href="/menu">
              Menu
            </a>
          </li>
        '.to_one_line)
      end

      context 'when custom attributes are sent' do
        let(:item) { super().merge({ attributes: { id: 'my-navigation', aria: { describedby: 'my-navigation' } } }) }

        it 'has the additional attributes on the link' do
          breadcrumb_link_anchor_element = breadcrumb_link_element.find('a.govuk-breadcrumbs__link')

          expect(breadcrumb_link_anchor_element[:id]).to eq('my-navigation')
          expect(breadcrumb_link_anchor_element[:'aria-describedby']).to eq('my-navigation')
        end
      end
    end

    context 'when only the text is passed' do
      let(:item) { { text: 'Menu' } }

      it 'has the Menu in the link' do
        expect(breadcrumb_link_element).not_to have_css('a', text: 'Menu')
        expect(breadcrumb_link_element).to have_content('Menu')
      end

      context 'when custom attributes are sent' do
        let(:item) { super().merge({ attributes: { id: 'my-navigation', aria: { describedby: 'my-navigation' } } }) }

        it 'does not have the additional attributes' do
          expect(breadcrumb_link_element[:id]).to be_nil
          expect(breadcrumb_link_element[:'aria-describedby']).to be_nil
        end
      end
    end
  end
end
