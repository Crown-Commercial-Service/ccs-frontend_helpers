# frozen_string_literal: true

require 'ccs/components/govuk/accordion/section/content'

RSpec.describe CCS::Components::GovUK::Accordion::Section::Content do
  let(:accordion_section_content) { Capybara::Node::Simple.new(result).find('div.govuk-accordion__section-content') }

  describe '.render' do
    let(:govuk_accordion_section_content) { described_class.new(section: section, accordion_id: accordion_id, index: index) }
    let(:result) { govuk_accordion_section_content.render }

    let(:accordion_id) { 'ouroboros' }
    let(:index) { 1 }

    context 'when there is text for the section' do
      let(:section) do
        {
          heading: 'Heading 1',
          text: 'Content 1'
        }
      end

      it 'correctly formats the HTML with the text in a p tag' do
        expect(accordion_section_content.to_html).to eq('
          <div class="govuk-accordion__section-content" id="ouroboros-content-1">
            <p class="govuk-body">
              Content 1
            </p>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is content for the section' do
      let(:section) do
        {
          heading: 'Heading 1',
          content: tag.div('Content 1', class: 'content-1', id: 'content-1')
        }
      end

      it 'correctly formats the HTML with the content' do
        expect(accordion_section_content.to_html).to eq('
          <div class="govuk-accordion__section-content" id="ouroboros-content-1">
              <div class="content-1" id="content-1">
                Content 1
              </div>
            </div>
        '.to_one_line)
      end
    end
  end
end
