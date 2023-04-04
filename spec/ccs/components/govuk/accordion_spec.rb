# frozen_string_literal: true

require 'ccs/components/govuk/accordion'

RSpec.describe CCS::Components::GovUK::Accordion do
  include_context 'and I have a view context'

  let(:accordion_element) { Capybara::Node::Simple.new(result).find('div.govuk-accordion') }
  let(:accordion_sections) { accordion_element.all('div.govuk-accordion__section') }

  describe '.render' do
    let(:govuk_accordion) { described_class.new(accordion_id: id, accordion_sections: accordion_items, context: view_context, **options) }
    let(:result) { govuk_accordion.render }

    let(:id) { 'ouroboros' }
    let(:accordion_items) do
      [
        {
          heading: 'Heading 1',
          text: 'Content 1'
        },
        {
          heading: 'Heading 2',
          summary: 'Summary 2',
          text: 'Content 2'
        },
        {
          heading: 'Heading 3',
          content: tag.div('Content 3', class: 'content-3', id: 'content-3')
        }
      ]
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-accordion" data-module="govuk-accordion" id="ouroboros">
          <div class="govuk-accordion__section">
            <div class="govuk-accordion__section-header">
              <h2 class="govuk-accordion__section-heading">
                <span class="govuk-accordion__section-button" id="ouroboros-heading-1">
                  Heading 1
                </span>
              </h2>
            </div>
            <div class="govuk-accordion__section-content" id="ouroboros-content-1" aria-labelledby="ouroboros-heading-1">
              <p class="govuk-body">
                Content 1
              </p>
            </div>
          </div>
          <div class="govuk-accordion__section">
            <div class="govuk-accordion__section-header">
              <h2 class="govuk-accordion__section-heading">
                <span class="govuk-accordion__section-button" id="ouroboros-heading-2">
                  Heading 2
                </span>
              </h2>
              <div class="govuk-accordion__section-summary govuk-body" id="ouroboros-summary-2">
                Summary 2
              </div>
            </div>
            <div class="govuk-accordion__section-content" id="ouroboros-content-2" aria-labelledby="ouroboros-heading-2">
              <p class="govuk-body">
                Content 2
              </p>
            </div>
          </div>
          <div class="govuk-accordion__section">
            <div class="govuk-accordion__section-header">
              <h2 class="govuk-accordion__section-heading">
                <span class="govuk-accordion__section-button" id="ouroboros-heading-3">
                  Heading 3
                </span>
              </h2>
            </div>
            <div class="govuk-accordion__section-content" id="ouroboros-content-3" aria-labelledby="ouroboros-heading-3">
              <div class="content-3" id="content-3">
                Content 3
              </div>
            </div>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the accordion sections' do
        expect(accordion_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_accordion) { described_class.new(accordion_id: id, accordion_sections: accordion_items, context: view_context) }

      it 'correctly formats the HTML with the accordion sections' do
        expect(accordion_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(accordion_element[:class]).to eq('govuk-accordion my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(accordion_element[:'data-module']).to eq('govuk-accordion')
        expect(accordion_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when heading level is passed' do
      let(:options) { { heading_level: 4 } }

      it 'the heading have the right heading level' do
        expect(accordion_sections[0]).to have_css('h4.govuk-accordion__section-heading', text: 'Heading 1')
        expect(accordion_sections[1]).to have_css('h4.govuk-accordion__section-heading', text: 'Heading 2')
        expect(accordion_sections[2]).to have_css('h4.govuk-accordion__section-heading', text: 'Heading 3')
      end
    end

    context 'when localisation data attributes are passed' do
      let(:options) do
        {
          attributes: {
            data: {
              'i18n.hide-all-sections': 'Collapse all sections',
              'i18n.show-all-sections': 'Expand all sections',
              'i18n.hide-section': 'Collapse',
              'i18n.hide-section-aria-label': 'Collapse this section',
              'i18n.show-section': 'Expand',
              'i18n.show-section-aria-label': 'Expand this section'
            }
          }
        }
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'renders with localisation elements' do
        expect(accordion_element[:'data-i18n.hide-all-sections']).to eq('Collapse all sections')
        expect(accordion_element[:'data-i18n.show-all-sections']).to eq('Expand all sections')
        expect(accordion_element[:'data-i18n.hide-section']).to eq('Collapse')
        expect(accordion_element[:'data-i18n.hide-section-aria-label']).to eq('Collapse this section')
        expect(accordion_element[:'data-i18n.show-section']).to eq('Expand')
        expect(accordion_element[:'data-i18n.show-section-aria-label']).to eq('Expand this section')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
end
