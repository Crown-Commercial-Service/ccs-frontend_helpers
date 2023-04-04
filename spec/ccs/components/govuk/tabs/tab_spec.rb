# frozen_string_literal: true

require 'ccs/components/govuk/tabs/tab'

RSpec.describe CCS::Components::GovUK::Tabs::Tab do
  include_context 'and I have a view context'

  let(:tabs_tab_element) { Capybara::Node::Simple.new(result).find('li.govuk-tabs__list-item') }
  let(:tabs_tab_link_element) { tabs_tab_element.find('a') }

  describe '.render' do
    let(:govuk_tabs_tab) { described_class.new(index: index, id_prefix: id_prefix, label: label, panel: panel, context: view_context, **options) }
    let(:result) { govuk_tabs_tab.render }

    let(:index) { 1 }
    let(:id_prefix) { 'content' }
    let(:label) { 'Eunie' }
    let(:panel) do
      {
        content: tag.div('Eunie is apparently, and this her words not mine, "the boss"', class: 'my-random-content'),
      }
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <li class="govuk-tabs__list-item govuk-tabs__list-item--selected">
          <a class="govuk-tabs__tab" href="#content-1">
            Eunie
          </a>
        </li>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the link' do
        expect(tabs_tab_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_tabs_tab) { described_class.new(index: index, id_prefix: id_prefix, label: label, panel: panel, context: view_context) }

      it 'correctly formats the HTML with the link' do
        expect(tabs_tab_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(tabs_tab_link_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'does not have the custom class' do
        expect(tabs_tab_link_element[:class]).to eq('govuk-tabs__tab')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(tabs_tab_link_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when the index is greater than 1' do
      let(:index) { 2 }

      it 'does not have the govuk-tabs__list-item--selected class' do
        expect(tabs_tab_element[:class]).to eq('govuk-tabs__list-item')
      end
    end

    context 'when the panel has an ID' do
      let(:panel) do
        {
          content: tag.div('Eunie is apparently, and this her words not mine, "the boss"', class: 'my-random-content'),
          attributes: {
            id: 'eunie'
          }
        }
      end

      it 'uses the panel id as the href' do
        expect(tabs_tab_link_element[:href]).to eq('#eunie')
      end
    end
  end
end
