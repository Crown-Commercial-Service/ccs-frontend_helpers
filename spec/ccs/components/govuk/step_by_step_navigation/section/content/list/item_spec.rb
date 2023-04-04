# frozen_string_literal: true

require 'ccs/components/govuk/step_by_step_navigation/section/content/list/item'

RSpec.describe CCS::Components::GovUK::StepByStepNavigation::Section::Content::List::Item do
  let(:step_by_step_navigation_list_item_element) { Capybara::Node::Simple.new(result).find('li.gem-c-step-nav__list-item') }

  describe '.render' do
    let(:govuk_step_by_step_navigation_list_item) { described_class.new(text: text, no_marker: no_marker) }
    let(:result) { govuk_step_by_step_navigation_list_item.render }

    let(:text) { 'I am the senate!' }
    let(:no_marker) { nil }

    it 'correctly formats the HTML for the list item' do
      expect(step_by_step_navigation_list_item_element.to_html).to eq('
        <li class="gem-c-step-nav__list-item js-list-item">
          <span>
            I am the senate!
          </span>
        </li>
      '.to_one_line)
    end

    context 'when no_marker is true' do
      let(:no_marker) { true }

      it 'has the no marker class' do
        expect(step_by_step_navigation_list_item_element[:class]).to eq('gem-c-step-nav__list-item js-list-item gem-c-step-nav__list--no-marker')
      end
    end

    context 'when no_marker is false' do
      let(:no_marker) { false }

      it 'does not have the no marker class' do
        expect(step_by_step_navigation_list_item_element[:class]).to eq('gem-c-step-nav__list-item js-list-item')
      end
    end
  end
end
