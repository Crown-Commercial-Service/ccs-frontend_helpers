# frozen_string_literal: true

require 'ccs/components/govuk/step_by_step_navigation/section/content'

RSpec.describe CCS::Components::GovUK::StepByStepNavigation::Section::Content do
  let(:step_by_step_navigation_content_element) { Capybara::Node::Simple.new(result).find('div.gem-c-step-nav__panel') }

  describe '.render' do
    let(:govuk_step_by_step_navigation_content) { described_class.new(content_items: content_items, index: index, id: id) }
    let(:result) { govuk_step_by_step_navigation_content.render }

    let(:content_items) do
      [
        {
          type: :paragraph,
          text: 'You must first join Ouroboros and gain the ability to interlink'
        },
        {
          type: :list,
          items: [
            {
              text: 'Noah'
            },
            {
              text: 'Lanz'
            },
            {
              text: 'Eunie'
            }
          ]
        }
      ]
    end
    let(:index) { '1' }
    let(:id) { 'section-1' }

    it 'correctly formats the HTML for the content' do
      expect(step_by_step_navigation_content_element.to_html).to eq('
        <div class="gem-c-step-nav__panel js-panel" id="step-panel-section-1-1">
          <p class="gem-c-step-nav__paragraph">
            You must first join Ouroboros and gain the ability to interlink
          </p>
          <ul class="gem-c-step-nav__list gem-c-step-nav__list--choice" data-length="3">
            <li class="gem-c-step-nav__list-item js-list-item">
              <span>
                Noah
              </span>
            </li>
            <li class="gem-c-step-nav__list-item js-list-item">
              <span>
                Lanz
              </span>
            </li>
            <li class="gem-c-step-nav__list-item js-list-item">
              <span>
                Eunie
              </span>
            </li>
          </ul>
        </div>
      '.to_one_line)
    end

    context 'when the index is changed' do
      let(:index) { '4' }

      it 'changes the content ID attribute' do
        expect(step_by_step_navigation_content_element[:id]).to eq('step-panel-section-1-4')
      end
    end

    context 'when the id is changed' do
      let(:id) { 'my-random-id' }

      it 'changes the content ID attribute' do
        expect(step_by_step_navigation_content_element[:id]).to eq('step-panel-my-random-id-1')
      end
    end
  end
end
