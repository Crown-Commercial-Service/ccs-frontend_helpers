# frozen_string_literal: true

require 'ccs/components/govuk/task_list/item/status'

RSpec.describe CCS::Components::GovUK::TaskList::Item::Status do
  include_context 'and I have a view context'

  let(:task_list_item_status_element) { Capybara::Node::Simple.new(result).find('div.govuk-task-list__status') }
  let(:task_list_item_status_tag_element) { task_list_item_status_element.find('strong') }

  describe '.render' do
    let(:govuk_task_list_item_status) { described_class.new(id_prefix: id_prefix, text: text, tag_options: tag_options, context: view_context, **options) }
    let(:result) { govuk_task_list_item_status.render }

    let(:id_prefix) { 'task-list-1' }
    let(:text) { 'Completed' }
    let(:tag_options) { nil }
    let(:options) { {} }

    let(:default_html) { '<div class="govuk-task-list__status" id="task-list-1-status">Completed</div>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the task list item status' do
        expect(task_list_item_status_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_task_list_item_status) { described_class.new(text: text, id_prefix: id_prefix, context: view_context) }

      it 'correctly formats the HTML with the task list item status' do
        expect(task_list_item_status_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(task_list_item_status_element[:class]).to eq('govuk-task-list__status my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { test: 'hello there' } } } }

      it 'does not have the additional attributes' do
        expect(task_list_item_status_element[:id]).to eq('task-list-1-status')
        expect(task_list_item_status_element[:'data-test']).to be_nil
      end
    end

    context 'when there is hint text' do
      let(:hint_text) { 'What is with this fog?' }

      it 'correctly formats the HTML with the task list item status' do
        expect(task_list_item_status_element.to_html).to eq(default_html)
      end
    end

    context 'and there is a status tag' do
      let(:tag_options) { { text: 'In progress' } }

      it 'correctly formats the HTML with the task list item status as a tag' do
        expect(task_list_item_status_element.to_html).to eq('<div class="govuk-task-list__status" id="task-list-1-status"><strong class="govuk-tag">In progress</strong></div>')
      end

      context 'when additional options for the tag options are passed' do
        context 'and a colour is given' do
          let(:tag_options) { super().merge({ colour: 'green' }) }

          it 'renders the tag in the phase banner with the correct colour' do
            expect(task_list_item_status_tag_element[:class]).to eq('govuk-tag govuk-tag--green')
          end
        end

        context 'and attributes are given' do
          let(:tag_options) { super().merge({ classes: 'my-custom-tag-class', attributes: { id: 'my-custom-tag-id' } }) }

          it 'renders the tag in the phase banner with additional attributes' do
            expect(task_list_item_status_tag_element[:class]).to eq('govuk-tag my-custom-tag-class')
            expect(task_list_item_status_tag_element[:id]).to eq('my-custom-tag-id')
          end
        end

        context 'and both colour and attributes are given' do
          let(:tag_options) { super().merge({ colour: 'green', classes: 'my-custom-tag-class', attributes: { id: 'my-custom-tag-id' } }) }

          it 'renders the tag in the phase banner with the correct colour additional attributes' do
            expect(task_list_item_status_tag_element[:class]).to eq('govuk-tag govuk-tag--green my-custom-tag-class')
            expect(task_list_item_status_tag_element[:id]).to eq('my-custom-tag-id')
          end
        end
      end
    end
  end
end
