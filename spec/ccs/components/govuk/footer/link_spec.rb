# frozen_string_literal: true

require 'ccs/components/govuk/footer/link'

RSpec.describe CCS::Components::GovUK::Footer::Link do
  include_context 'and I have a view context'

  let(:footer_navigation_item_element) { Capybara::Node::Simple.new(result).find('li') }
  let(:footer_navigation_item_link) { footer_navigation_item_element.find('a') }

  describe '.render' do
    let(:govuk_footer_navigation_link) { described_class.new(text: text, href: href, li_class: li_class, context: view_context, **options) }
    let(:result) { govuk_footer_navigation_link.render }

    let(:text) { 'Go Beyond' }
    let(:href) { '/go-beyond' }
    let(:li_class) { 'govuk-footer__navigation-item' }

    let(:options) { {} }

    let(:default_html) { '<li class="govuk-footer__navigation-item"><a class="govuk-footer__link" href="/go-beyond">Go Beyond</a></li>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the text and href' do
        expect(footer_navigation_item_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_footer_navigation_link) { described_class.new(text: text, href: href, li_class: li_class, context: view_context) }

      it 'correctly formats the HTML with the text and href' do
        expect(footer_navigation_item_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-navigation-item-id' } } }

      it 'has the id' do
        expect(footer_navigation_item_link[:id]).to eq('my-custom-navigation-item-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { attributes: { class: 'my-custom-navigation-item-class' } } }

      it 'does not have the custom class' do
        expect(footer_navigation_item_link[:class]).to eq 'govuk-footer__link'
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(footer_navigation_item_link[:'data-test']).to eq('hello there')
      end
    end
  end
end
