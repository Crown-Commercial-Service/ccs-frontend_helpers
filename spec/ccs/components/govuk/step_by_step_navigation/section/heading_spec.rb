# frozen_string_literal: true

require 'ccs/components/govuk/step_by_step_navigation/section/heading'

RSpec.describe CCS::Components::GovUK::StepByStepNavigation::Section::Heading do
  let(:step_by_step_navigation_heading_element) { Capybara::Node::Simple.new(result).find('div.gem-c-step-nav__header') }

  describe '.render' do
    let(:govuk_step_by_step_navigation_heading) { described_class.new(text: text, index: index, logic: logic) }
    let(:result) { govuk_step_by_step_navigation_heading.render }

    let(:text) { 'Join Ouroboros' }
    let(:index) { '1' }
    let(:logic) { nil }

    let(:default_html) do
      '
        <div class="gem-c-step-nav__header js-toggle-panel" data-position="1">
          <h2 class="gem-c-step-nav__title">
            <span class="gem-c-step-nav__circle gem-c-step-nav__circle--number">
              <span class="gem-c-step-nav__circle-inner">
                <span class="gem-c-step-nav__circle-background">
                  <span class="govuk-visually-hidden">
                    Step
                  </span>
                  1
                </span>
              </span>
            </span>
            <span class="js-step-title">
              <span class="js-step-title-text">
                Join Ouroboros
              </span>
            </span>
          </h2>
        </div>
      '.to_one_line
    end

    it 'correctly formats the HTML for the heading' do
      expect(step_by_step_navigation_heading_element.to_html).to eq(default_html)
    end

    context 'when only required arguments are passed' do
      let(:govuk_step_by_step_navigation_heading) { described_class.new(text: text, index: index) }

      it 'correctly formats the HTML for the heading' do
        expect(step_by_step_navigation_heading_element.to_html).to eq(default_html)
      end
    end

    context 'when the index is changed' do
      let(:index) { '3' }

      it 'changes the heading data position attribute' do
        expect(step_by_step_navigation_heading_element[:'data-position']).to eq('3')
      end
    end

    context 'when logic is given' do
      let(:logic) { 'or' }

      it 'changes the circle class to logic and has the logic text' do
        expect(step_by_step_navigation_heading_element.find('.gem-c-step-nav__circle')[:class]).to eq('gem-c-step-nav__circle gem-c-step-nav__circle--logic')
        expect(step_by_step_navigation_heading_element.find('.gem-c-step-nav__circle-background')).to have_content('or')
      end
    end
  end
end
