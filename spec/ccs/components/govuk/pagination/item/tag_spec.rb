# frozen_string_literal: true

require 'ccs/components/govuk/pagination/item/tag'

RSpec.describe CCS::Components::GovUK::Pagination::Item::Tag do
  include_context 'and I have a view context'

  let(:pagination_item_element) { Capybara::Node::Simple.new(result).find('li.govuk-pagination__item') }
  let(:pagination_item_link_element) { pagination_item_element.find('a') }

  describe '.render' do
    let(:govuk_pagination_tag) { described_class.new(number: number, href: href, context: view_context, **options) }
    let(:result) { govuk_pagination_tag.render }

    let(:number) { '3' }
    let(:href) { '/?page=3' }
    let(:options) { {} }

    let(:default_html) do
      '
        <li class="govuk-pagination__item">
          <a class="govuk-link govuk-pagination__link" aria-label="Page 3" href="/?page=3">
            3
          </a>
        </li>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with pagination link' do
        expect(pagination_item_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_pagination_tag) { described_class.new(number: number, href: href, context: view_context) }

      it 'correctly formats the HTML with pagination link' do
        expect(pagination_item_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class on the link element' do
        expect(pagination_item_link_element[:class]).to eq('govuk-link govuk-pagination__link my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { aria: { label: 'custom aria label' }, data: { test: 'hello there' }, id: 'custom-id' } } }

      it 'has the additional attributes on the link element' do
        expect(pagination_item_link_element[:'aria-label']).to eq('custom aria label')
        expect(pagination_item_link_element[:'data-test']).to eq('hello there')
        expect(pagination_item_link_element[:id]).to eq('custom-id')
      end
    end

    context 'when current is true' do
      let(:options) { { current: true } }

      it 'has the current class on the list' do
        expect(pagination_item_element[:class]).to eq('govuk-pagination__item govuk-pagination__item--current')
      end

      it 'has the current aria attribute on the link' do
        expect(pagination_item_link_element[:'aria-current']).to eq('page')
      end
    end

    context 'when the number is changed' do
      let(:number) { '6' }

      it 'changes the link aria label' do
        expect(pagination_item_link_element[:'aria-label']).to eq('Page 6')
      end
    end
  end
end
