# frozen_string_literal: true

require 'ccs/components/govuk/task_list/item/title'

RSpec.describe CCS::Components::GovUK::TaskList::Item::Title do
  include_context 'and I have a view context'

  let(:task_list_item_title_element) { Capybara::Node::Simple.new(result).find('div') }

  describe '.render' do
    let(:govuk_task_list_item_title) { described_class.new(text: text, id_prefix: id_prefix, href: href, hint_text: hint_text, context: view_context, **options) }
    let(:result) { govuk_task_list_item_title.render }

    let(:text) { 'Chapter 1: Ouroboros' }
    let(:id_prefix) { 'task-list-1' }
    let(:href) { nil }
    let(:hint_text) { nil }
    let(:options) { {} }

    let(:default_html) { '<div>Chapter 1: Ouroboros</div>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the task list item title' do
        expect(task_list_item_title_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_task_list_item_title) { described_class.new(text: text, id_prefix: id_prefix, context: view_context) }

      it 'correctly formats the HTML with the task list item title' do
        expect(task_list_item_title_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(task_list_item_title_element[:class]).to eq('my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(task_list_item_title_element[:id]).to be_nil
        expect(task_list_item_title_element[:'data-test']).to be_nil
      end
    end

    context 'when there is hint text' do
      let(:hint_text) { 'What is with this fog?' }

      it 'correctly formats the HTML with the task list item title' do
        expect(task_list_item_title_element.to_html).to eq(default_html)
      end
    end

    context 'and there is a title href' do
      let(:task_list_item_title_element) { Capybara::Node::Simple.new(result).find('a') }
      let(:href) { '/chapter/1-ouroboros' }

      it 'correctly formats the HTML with the task list item title as a link' do
        expect(task_list_item_title_element.to_html).to eq('
          <a class="govuk-link govuk-task-list__link" aria-describedby="task-list-1-status" href="/chapter/1-ouroboros">
            Chapter 1: Ouroboros
          </a>
        '.to_one_line)
      end

      context 'and there is hint text' do
        let(:hint_text) { 'What is with this fog?' }

        it 'correctly formats the HTML with the task list item title as a link with the aria attributes' do
          expect(task_list_item_title_element.to_html).to eq('
            <a class="govuk-link govuk-task-list__link" aria-describedby="task-list-1-hint task-list-1-status" href="/chapter/1-ouroboros">
              Chapter 1: Ouroboros
            </a>
          '.to_one_line)
        end
      end
    end
  end
end
