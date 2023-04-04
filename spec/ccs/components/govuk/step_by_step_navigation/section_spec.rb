# frozen_string_literal: true

require 'ccs/components/govuk/step_by_step_navigation/section'

RSpec.describe CCS::Components::GovUK::StepByStepNavigation::Section do
  include_context 'and I have a view context'

  let(:step_by_step_navigation_section_element) { Capybara::Node::Simple.new(result).find('li.gem-c-step-nav__step') }

  describe '.render' do
    let(:govuk_step_by_step_navigation_section) { described_class.new(heading: heading, content: content, index: index, context: view_context) }
    let(:result) { govuk_step_by_step_navigation_section.render }

    let(:heading) do
      {
        text: 'Join Ouroboros'
      }
    end
    let(:content) do
      [
        {
          type: :paragraph,
          text: 'You must first join Ouroboros and gain the ability to interlink'
        }
      ]
    end
    let(:index) { '1' }

    it 'correctly formats the HTML for the heading' do
      expect(step_by_step_navigation_section_element.to_html).to eq('
        <li class="gem-c-step-nav__step js-step" id="join-ouroboros">
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
          <div class="gem-c-step-nav__panel js-panel" id="step-panel-join-ouroboros-1">
            <p class="gem-c-step-nav__paragraph">
              You must first join Ouroboros and gain the ability to interlink
            </p><
          /div>
        </li>
      '.to_one_line)
    end
  end
end
