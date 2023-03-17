# frozen_string_literal: true

require 'ccs/components/govuk/step_by_step_navigation/section/content/paragraph'

RSpec.describe CCS::Components::GovUK::StepByStepNavigation::Section::Content::Paragraph do
  let(:step_by_step_navigation_paragraph_element) { Capybara::Node::Simple.new(result).find('p.gem-c-step-nav__paragraph') }

  describe '.render' do
    let(:govuk_step_by_step_navigation_paragraph) { described_class.new(text: text) }
    let(:result) { govuk_step_by_step_navigation_paragraph.render }

    let(:text) { 'You must first join Ouroboros and gain the ability to interlink' }

    it 'correctly formats the HTML for the paragraph' do
      expect(step_by_step_navigation_paragraph_element.to_html).to eq('<p class="gem-c-step-nav__paragraph">You must first join Ouroboros and gain the ability to interlink</p>')
    end
  end
end
