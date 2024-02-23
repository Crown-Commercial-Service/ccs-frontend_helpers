# frozen_string_literal: true

require 'ccs/components/govuk/accordion/section'

RSpec.describe CCS::Components::GovUK::Accordion::Section do
  let(:accordion_section) { Capybara::Node::Simple.new(result).find('div.govuk-accordion__section') }

  describe '.render' do
    let(:govuk_accordion_section) { described_class.new(section: section, accordion_id: accordion_id, index: index, heading_level: heading_level) }
    let(:result) { govuk_accordion_section.render }

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
      it 'correctly formats the HTML for the accordion section' do
        expect(accordion_section.to_html).to eq('
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
        '.to_one_line)
      end
    end

    context 'when the section is expanded' do
      let(:section) do
        {
          heading: 'Heading 1',
          text: 'Content 1',
          expanded: true
        }
      end

      it 'has the expanded class' do
        expect(accordion_section[:class]).to eq('govuk-accordion__section govuk-accordion__section--expanded')
      end
    end
  end
end
