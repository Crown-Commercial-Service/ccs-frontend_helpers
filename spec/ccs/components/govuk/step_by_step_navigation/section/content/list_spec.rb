# frozen_string_literal: true

require 'ccs/components/govuk/step_by_step_navigation/section/content/list'

RSpec.describe CCS::Components::GovUK::StepByStepNavigation::Section::Content::List do
  let(:step_by_step_navigation_list_element) { Capybara::Node::Simple.new(result).find('ul.gem-c-step-nav__list') }

  describe '.render' do
    let(:govuk_step_by_step_navigation_list) { described_class.new(items: items) }
    let(:result) { govuk_step_by_step_navigation_list.render }

    let(:items) do
      [
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
    end

    it 'correctly formats the HTML for the list' do
      expect(step_by_step_navigation_list_element.to_html).to eq('
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
      '.to_one_line)
    end

    context 'when the number of items changes' do
      let(:items) do
        [
          {
            text: 'Noah'
          },
          {
            text: 'Lanz'
          },
          {
            text: 'Eunie'
          },
          {
            text: 'Mio'
          },
          {
            text: 'Taion'
          },
          {
            text: 'Sena'
          }
        ]
      end

      it 'changes the data attribute' do
        expect(step_by_step_navigation_list_element[:'data-length']).to eq('6')
      end
    end
  end
end
