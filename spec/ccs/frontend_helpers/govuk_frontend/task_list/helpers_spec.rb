# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/task_list'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::TaskList, '#helpers', type: :helper do
  include described_class

  let(:task_list_element) { Capybara::Node::Simple.new(result).find('ul.govuk-task-list') }

  describe '.govuk_task_list' do
    let(:result) { govuk_task_list(task_list, **options) }

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
              text: 'Completed'
            }
          }
        }
      ]
    end
    let(:options) { {} }

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
            <div class="govuk-task-list__status" id="task-list-3-status"><strong class="govuk-tag">Completed</strong></div>
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
      let(:result) { govuk_task_list(task_list) }

      it 'correctly formats the HTML with the task list' do
        expect(task_list_element.to_html).to eq(default_html)
      end
    end
  end
end
