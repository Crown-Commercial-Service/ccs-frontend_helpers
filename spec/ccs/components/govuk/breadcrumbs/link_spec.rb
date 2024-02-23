# frozen_string_literal: true

require 'ccs/components/govuk/breadcrumbs/link'

RSpec.describe CCS::Components::GovUK::Breadcrumbs::Link do
  include_context 'and I have a view context'

  let(:breadcrumb_link_element) { Capybara::Node::Simple.new(result).find('li.govuk-breadcrumbs__list-item') }

  describe '.render' do
    let(:govuk_breadcrumb_link) { described_class.new(context: view_context, **item) }
    let(:result) { govuk_breadcrumb_link.render }

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

      it 'has the text in the li without a link' do
        expect(breadcrumb_link_element).to have_no_css('a', text: 'Menu')
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
