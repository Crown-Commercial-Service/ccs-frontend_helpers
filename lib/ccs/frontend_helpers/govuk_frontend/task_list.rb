# frozen_string_literal: true

require_relative '../../components/govuk/task_list'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Task list
      #
      # This helper is used for generating the task list component from the
      # {https://design-system.service.gov.uk/components/task-list GDS - Components - Task list}

      module TaskList
        # Generates the HTML for the GOV.UK Task list component
        #
        # @param (see CCS::Components::GovUK::TaskList#initialize)
        #
        # @option (see CCS::Components::GovUK::TaskList#initialize)
        #
        # @return (see CCS::Components::GovUK::TaskList#render)

        def govuk_task_list(task_list_items, **options)
          Components::GovUK::TaskList.new(context: self, task_list_items: task_list_items, **options).render
        end
      end
    end
  end
end
