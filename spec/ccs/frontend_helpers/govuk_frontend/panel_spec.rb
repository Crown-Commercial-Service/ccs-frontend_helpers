# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/panel'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Panel, type: :helper do
  include described_class

  let(:panel_element) { Capybara::Node::Simple.new(result).find('div.govuk-panel') }

  describe '.govuk_panel' do
    let(:result) { govuk_panel(title_text, panel_text, **options) }

    let(:title_text) { "Eunie's the boss" }
    let(:panel_text) { 'Come on, who else?' }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-panel govuk-panel--confirmation">
          <h1>
            Eunie\'s the boss
          </h1>
          <div class="govuk-panel__body">
            Come on, who else?
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the link' do
        expect(panel_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_panel(title_text, panel_text) }

      it 'correctly formats the HTML with the link' do
        expect(panel_element.to_html).to eq(default_html)
      end
    end

    context 'when a heading level is passed' do
      let(:options) { { heading_level: 3 } }

      it 'has the correct heading level' do
        expect(panel_element).to have_css('h3', text: "Eunie's the boss")
      end
    end

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-panel' } } }

      it 'has the id' do
        expect(panel_element[:id]).to eq('ouroboros-panel')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(panel_element[:class]).to eq('govuk-panel govuk-panel--confirmation my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(panel_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when there is a block' do
      let(:result) do
        govuk_panel(title_text, **options) do
          tag.p('Hear that Noah? Lanz wants something a bit meatier')
        end
      end

      it 'renders the panel with the block' do
        expect(panel_element.to_html).to eq('
          <div class="govuk-panel govuk-panel--confirmation">
            <h1>
              Eunie\'s the boss
            </h1>
            <div class="govuk-panel__body">
              <p>
                Hear that Noah? Lanz wants something a bit meatier
              </p>
            </div>
          </div>
        '.to_one_line)
      end

      context 'and there is panel text too' do
        let(:result) do
          govuk_panel(title_text, panel_text, **options) do
            tag.p('Hear that Noah? Lanz wants something a bit meatier')
          end
        end

        it 'renders only the panel text and not the block' do
          expect(panel_element.to_html).to eq(default_html)
        end
      end
    end

    context 'when there is no label text or block' do
      let(:result) { govuk_panel(title_text, **options) }

      it 'does not render any panel body' do
        expect(panel_element).not_to have_css('div.govuk-panel__body')
      end
    end
  end
end
