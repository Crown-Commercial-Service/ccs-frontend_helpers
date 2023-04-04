# frozen_string_literal: true

require 'ccs/components/govuk/breadcrumbs'

RSpec.describe CCS::Components::GovUK::Breadcrumbs do
  include_context 'and I have a view context'

  let(:breadcrumbs_element) { Capybara::Node::Simple.new(result).find('div.govuk-breadcrumbs') }

  describe '.render' do
    let(:govuk_breadcrumbs) { described_class.new(breadcrumb_links: items, context: view_context, **options) }
    let(:result) { govuk_breadcrumbs.render }

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

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the text and content' do
        expect(breadcrumbs_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_breadcrumbs) { described_class.new(breadcrumb_links: items, context: view_context) }

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
end
