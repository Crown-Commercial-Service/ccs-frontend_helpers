# frozen_string_literal: true

require 'ccs/components/govuk/task_list'

RSpec.describe CCS::Components::GovUK::TaskList do
  include_context 'and I have a view context'

  let(:task_list_element) { Capybara::Node::Simple.new(result).find('ul.govuk-task-list') }
  let(:task_list_row_elements) { task_list_element.all('li.govuk-task-list__item') }

  let(:task_list) do
    [
      {
        title: {
          text: 'Chapter 1: Ouroboros'
        },
        status: {
          text: 'Completed'
        }
      },
      {
        title: {
          text: 'Chapter 2: Moebius'
        },
        status: {
          text: 'Completed'
        }
      },
      {
        title: {
          text: 'Chapter 3: Saffronias',
          href: '/chapter/3-saffronias'
        },
        hint_text: 'Who is console J?',
        status: {
          tag_options: {
            text: 'In progress'
          }
        }
      }
    ]
  end
  let(:options) { {} }

  describe '.render' do
    let(:govuk_task_list) { described_class.new(task_list_items: task_list, context: view_context, **options) }
    let(:result) { govuk_task_list.render }

    let(:default_html) do
      '
        <ul class="govuk-task-list">
          <li class="govuk-task-list__item">
            <div class="govuk-task-list__name-and-hint">
              <div>Chapter 1: Ouroboros</div>
            </div>
            <div class="govuk-task-list__status" id="task-list-1-status">Completed</div>
          </li>
          <li class="govuk-task-list__item">
            <div class="govuk-task-list__name-and-hint">
              <div>Chapter 2: Moebius</div>
            </div>
            <div class="govuk-task-list__status" id="task-list-2-status">Completed</div>
          </li>
          <li class="govuk-task-list__item govuk-task-list__item--with-link">
            <div class="govuk-task-list__name-and-hint">
              <a class="govuk-link govuk-task-list__link" aria-describedby="task-list-3-hint task-list-3-status" href="/chapter/3-saffronias">
                Chapter 3: Saffronias
              </a>
              <div class="govuk-task-list__hint" id="task-list-3-hint">Who is console J?</div>
            </div>
            <div class="govuk-task-list__status" id="task-list-3-status"><strong class="govuk-tag">In progress</strong></div>
          </li>
        </ul>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the task list' do
        expect(task_list_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_task_list) { described_class.new(task_list_items: task_list, context: view_context) }

      it 'correctly formats the HTML with the task list' do
        expect(task_list_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(task_list_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(task_list_element[:class]).to eq('govuk-task-list my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(task_list_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when a custom id prefix is passed' do
      let(:options) { { id_prefix: 'custom-id-prefix' } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the custom id prefix on the correct elements' do
        expect(task_list_row_elements[0].find('div.govuk-task-list__status')[:id]).to eq('custom-id-prefix-1-status')
        expect(task_list_row_elements[1].find('div.govuk-task-list__status')[:id]).to eq('custom-id-prefix-2-status')
        expect(task_list_row_elements[2].find('a.govuk-task-list__link')[:'aria-describedby']).to eq('custom-id-prefix-3-hint custom-id-prefix-3-status')
        expect(task_list_row_elements[2].find('div.govuk-task-list__hint')[:id]).to eq('custom-id-prefix-3-hint')
        expect(task_list_row_elements[2].find('div.govuk-task-list__status')[:id]).to eq('custom-id-prefix-3-status')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
end
