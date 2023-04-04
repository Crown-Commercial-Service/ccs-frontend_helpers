# frozen_string_literal: true

require 'ccs/components/govuk/footer/meta'

RSpec.describe CCS::Components::GovUK::Footer::Meta do
  include_context 'and I have a view context'

  let(:footer_meta_section_element) { Capybara::Node::Simple.new(result).find('body') }

  describe '.render' do
    let(:govuk_footer_meta) { described_class.new(items: meta_links, visually_hidden_title: visually_hidden_title, text: text, context: view_context) }
    let(:result) { govuk_footer_meta.render }

    let(:meta_links) do
      [
        {
          text: 'Plus',
          href: '/plus'
        },
        {
          text: 'Ultra',
          href: '/ultra'
        }
      ]
    end
    let(:visually_hidden_title) { nil }
    let(:text) { nil }

    let(:default_html) do
      '
        <body>
          <h2 class="govuk-visually-hidden">
            Support links
          </h2>
          <ul class="govuk-footer__inline-list">
            <li class="govuk-footer__inline-list-item">
              <a class="govuk-footer__link" href="/plus">Plus</a>
            </li>
            <li class="govuk-footer__inline-list-item">
              <a class="govuk-footer__link" href="/ultra">Ultra</a>
            </li>
          </ul>
        </body>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the footer meta section' do
        expect(footer_meta_section_element.to_html).to eq(default_html)
      end
    end

    context 'when no optional arguments are sent' do
      let(:govuk_footer_meta) { described_class.new(items: meta_links, context: view_context) }

      it 'correctly formats the HTML for the footer meta section' do
        expect(footer_meta_section_element.to_html).to eq(default_html)
      end
    end

    context 'and visually_hidden_title is provided' do
      let(:visually_hidden_title) { 'What do the words mean?' }

      it 'has the custom visually hidden itle' do
        expect(footer_meta_section_element).to have_css('h2.govuk-visually-hidden', text: 'What do the words mean?')
      end
    end

    context 'and text is provided' do
      let(:text) { 'Here is some custom meta text' }

      it 'has the additional meta text' do
        expect(footer_meta_section_element).to have_css('div.govuk-footer__meta-custom', text: 'Here is some custom meta text')
      end
    end
  end
end
