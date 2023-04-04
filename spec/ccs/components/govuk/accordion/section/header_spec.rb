# frozen_string_literal: true

require 'ccs/components/govuk/accordion/section/header'

RSpec.describe CCS::Components::GovUK::Accordion::Section::Header do
  let(:accordion_section_header) { Capybara::Node::Simple.new(result).find('div.govuk-accordion__section-header') }

  describe '.render' do
    let(:govuk_accordion_section_header) { described_class.new(section: section, accordion_id: accordion_id, index: index, heading_level: heading_level) }
    let(:result) { govuk_accordion_section_header.render }

    let(:accordion_id) { 'ouroboros' }
    let(:section) do
      {
        heading: 'Heading 1',
        text: 'Content 1'
      }
    end
    let(:index) { 1 }
    let(:heading_level) { 2 }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the accordion section header' do
        expect(accordion_section_header.to_html).to eq('
          <div class="govuk-accordion__section-header">
            <h2 class="govuk-accordion__section-heading">
              <span class="govuk-accordion__section-button" id="ouroboros-heading-1">
                Heading 1
              </span>
            </h2>
          </div>
        '.to_one_line)
      end
    end

    context 'when a different heading level is passed' do
      let(:heading_level) { 4 }

      it 'the heading have the right heading level' do
        expect(accordion_section_header).to have_css('h4.govuk-accordion__section-heading', text: 'Heading 1')
      end
    end

    context 'when there is a summary' do
      let(:section) do
        {
          heading: 'Heading 1',
          summary: 'Summary 1',
          text: 'Content 1'
        }
      end

      it 'correctly formats the HTML with the summary' do
        expect(accordion_section_header.to_html).to eq('
          <div class="govuk-accordion__section-header">
            <h2 class="govuk-accordion__section-heading">
              <span class="govuk-accordion__section-button" id="ouroboros-heading-1">
                Heading 1
              </span>
            </h2>
            <div class="govuk-accordion__section-summary govuk-body" id="ouroboros-summary-1">
              Summary 1
            </div>
          </div>
        '.to_one_line)
      end
    end
  end
end
