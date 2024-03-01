# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/accordion'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Accordion, '#helpers', type: :helper do
  include described_class

  let(:accordion_element) { Capybara::Node::Simple.new(result).find('div.govuk-accordion') }

  describe '.govuk_accordion' do
    let(:result) { govuk_accordion(id, accordion_items, **options) }

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
            <div class="govuk-accordion__section-content" id="ouroboros-content-1">
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
            <div class="govuk-accordion__section-content" id="ouroboros-content-2">
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
            <div class="govuk-accordion__section-content" id="ouroboros-content-3">
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
      let(:result) { govuk_accordion(id, accordion_items) }

      it 'correctly formats the HTML with the accordion sections' do
        expect(accordion_element.to_html).to eq(default_html)
      end
    end
  end
end
