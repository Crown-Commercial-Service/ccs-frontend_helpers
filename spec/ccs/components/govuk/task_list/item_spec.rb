# frozen_string_literal: true

require 'ccs/components/govuk/task_list/item'

RSpec.describe CCS::Components::GovUK::TaskList::Item do
  include_context 'and I have a view context'

  let(:task_list_item_element) { Capybara::Node::Simple.new(result).find('li.govuk-task-list__item') }

  describe '.render' do
    let(:govuk_task_list_item) { described_class.new(title: title, status: status, index: index, id_prefix: id_prefix, hint_text: hint_text, context: view_context, **options) }
    let(:result) { govuk_task_list_item.render }

    let(:title) { { text: 'Chapter 1: Ouroboros' } }
    let(:status) { { text: 'Completed' } }
    let(:index) { 1 }
    let(:id_prefix) { 'task-list' }
    let(:hint_text) { nil }
    let(:options) { {} }

    let(:default_html) do
      '
        <li class="govuk-task-list__item">
          <div class="govuk-task-list__name-and-hint">
            <div>Chapter 1: Ouroboros</div>
          </div>
          <div class="govuk-task-list__status" id="task-list-1-status">Completed</div>
        </li>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the task list item' do
        expect(task_list_item_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_task_list_item) { described_class.new(title: title, status: status, index: index, id_prefix: id_prefix, context: view_context) }

      it 'correctly formats the HTML with the task list item' do
        expect(task_list_item_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(task_list_item_element[:class]).to eq('govuk-task-list__item my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(task_list_item_element[:id]).to be_nil
        expect(task_list_item_element[:'data-test']).to be_nil
      end
    end

    context 'when there is hint text' do
      let(:hint_text) { 'What is with this fog?' }

      it 'has added the hint to the task list item' do
        expect(task_list_item_element.to_html).to eq('
          <li class="govuk-task-list__item">
            <div class="govuk-task-list__name-and-hint">
              <div>Chapter 1: Ouroboros</div>
              <div class="govuk-task-list__hint" id="task-list-1-hint">
                What is with this fog?
              </div>
            </div>
            <div class="govuk-task-list__status" id="task-list-1-status">Completed</div>
          </li>
        '.to_one_line)
      end
    end

    context 'and there is a title href' do
      let(:title) { { text: 'Chapter 1: Ouroboros', href: '/chapter/1-ouroboros' } }

      it 'has the aria attributes on the link' do
        expect(task_list_item_element.to_html).to eq('
          <li class="govuk-task-list__item govuk-task-list__item--with-link">
            <div class="govuk-task-list__name-and-hint">
              <a class="govuk-link govuk-task-list__link" aria-describedby="task-list-1-status" href="/chapter/1-ouroboros">
                Chapter 1: Ouroboros
              </a>
            </div>
            <div class="govuk-task-list__status" id="task-list-1-status">Completed</div>
          </li>
        '.to_one_line)
      end

      context 'and there is hint text' do
        let(:hint_text) { 'What is with this fog?' }

        it 'has added the hint to the task list item with the aria attributes on the link' do
          expect(task_list_item_element.to_html).to eq('
            <li class="govuk-task-list__item govuk-task-list__item--with-link">
              <div class="govuk-task-list__name-and-hint">
                <a class="govuk-link govuk-task-list__link" aria-describedby="task-list-1-hint task-list-1-status" href="/chapter/1-ouroboros">
                  Chapter 1: Ouroboros
                </a>
                <div class="govuk-task-list__hint" id="task-list-1-hint">
                  What is with this fog?
                </div>
              </div>
              <div class="govuk-task-list__status" id="task-list-1-status">Completed</div>
            </li>
          '.to_one_line)
        end
      end
    end
  end
end
