# frozen_string_literal: true

require 'ccs/components/govuk/tabs/panel'

RSpec.describe CCS::Components::GovUK::Tabs::Panel do
  include_context 'and I have a view context'

  let(:tabs_panel_element) { Capybara::Node::Simple.new(result).find('div.govuk-tabs__panel') }

  describe '.render' do
    let(:govuk_tabs_panel) { described_class.new(index: index, id_prefix: id_prefix, content: content, text: text, context: view_context, **options) }
    let(:result) { govuk_tabs_panel.render }

    let(:index) { 1 }
    let(:id_prefix) { 'content' }
    let(:content) { tag.div('Eunie is apparently, and these are her words not mine, "the boss"', class: 'my-random-content') }
    let(:text) { nil }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-tabs__panel" id="content-1">
          <div class="my-random-content">
            Eunie is apparently, and these are her words not mine, "the boss"
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the content' do
        expect(tabs_panel_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_tabs_panel) { described_class.new(index: index, id_prefix: id_prefix, content: content, context: view_context) }

      it 'correctly formats the HTML with the content' do
        expect(tabs_panel_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(tabs_panel_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'does not have the custom class' do
        expect(tabs_panel_element[:class]).to eq('govuk-tabs__panel')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(tabs_panel_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when only text is sent' do
      let(:content) { nil }
      let(:text) { "Eunie's the boss" }

      it 'renders the text' do
        expect(tabs_panel_element).to have_css('p.govuk-body', text: "Eunie's the boss")
      end
    end

    context 'when both text and content is sent' do
      let(:text) { "Eunie's the boss" }

      it 'renders the content only' do
        expect(tabs_panel_element).to have_no_css('p.govuk-body', text: "Eunie's the boss")
        expect(tabs_panel_element).to have_css('div.my-random-content', text: 'Eunie is apparently, and these are her words not mine, "the boss"')
      end
    end

    context 'when the index is greater than 1' do
      let(:index) { 2 }

      it 'has the govuk-tabs__panel--hidden class' do
        expect(tabs_panel_element[:class]).to eq('govuk-tabs__panel govuk-tabs__panel--hidden')
      end
    end
  end
end
