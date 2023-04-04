# frozen_string_literal: true

require 'ccs/components/govuk/footer/navigation'

RSpec.describe CCS::Components::GovUK::Footer::Navigation do
  include_context 'and I have a view context'

  let(:footer_navigation_section_element) { Capybara::Node::Simple.new(result).find('div.govuk-footer__section') }

  describe '.render' do
    let(:govuk_footer_navigation) { described_class.new(title: title, items: navigation_links, width: width, columns: columns, context: view_context) }
    let(:result) { govuk_footer_navigation.render }

    let(:title) { 'My hero Academia' }
    let(:navigation_links) do
      [
        {
          text: 'Go',
          href: '/go'
        },
        {
          text: 'Beyond',
          href: '/beyond'
        }
      ]
    end
    let(:width) { nil }
    let(:columns) { nil }

    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-footer__section govuk-grid-column-full">
          <h2 class="govuk-footer__heading govuk-heading-m">
            My hero Academia
          </h2>
          <ul class="govuk-footer__list">
            <li class="govuk-footer__list-item">
              <a class="govuk-footer__link" href="/go">Go</a>
            </li>
            <li class="govuk-footer__list-item">
              <a class="govuk-footer__link" href="/beyond">Beyond</a>
            </li>
          </ul>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the footer navigation section' do
        expect(footer_navigation_section_element.to_html).to eq(default_html)
      end
    end

    context 'when no optional arguments are sent' do
      let(:govuk_footer_navigation) { described_class.new(title: title, items: navigation_links, context: view_context) }

      it 'correctly formats the HTML for the footer navigation section' do
        expect(footer_navigation_section_element.to_html).to eq(default_html)
      end
    end

    context 'and width is provided' do
      let(:width) { 'two-thirds' }

      it 'has the custom column width class' do
        expect(footer_navigation_section_element[:class]).to eq('govuk-footer__section govuk-grid-column-two-thirds')
      end
    end

    context 'and a columns is provided' do
      let(:columns) { 2 }

      it 'has the columns class with the right number' do
        expect(footer_navigation_section_element).to have_css('ul.govuk-footer__list.govuk-footer__list--columns-2')
      end
    end
  end
end
