require_relative '../base'
require_relative 'task_list/item'

module CCS
  module Components
    module GovUK
      # = GOV.UK Task list
      #
      # This is used to generate the task list component from the
      # {https://design-system.service.gov.uk/components/task-list GDS - Components - Task list}
      #
      # @!attribute [r] task_list_items
      #   @return [Array<Link>] An array of the initialised task list items

      class TaskList < Base
        private

        attr_reader :task_list_items

        public

        # @param task_list_items [Array<Hash>] An array of task list items.
        #                                      See {Components::GovUK::TaskList::Item#initialize Item#initialize} for details of the items in the array.
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the task list HTML
        # @option options [Sting] :id_prefix id prefix for the task list, defaults to +'task-list'+
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

        def initialize(task_list_items:, id_prefix: nil, **options)
          super(**options)

          @task_list_items = task_list_items.map.with_index(1) { |task_list_item, index| Item.new(context: @context, index: index, id_prefix: id_prefix || 'task-list', **task_list_item) }
        end

        # Generates the HTML for the GOV.UK task list component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.ul(**options[:attributes]) do
            task_list_items.each { |task_list_item| concat(task_list_item.render) }
          end
        end

        # The default attributes for the task list

        DEFAULT_ATTRIBUTES = { class: 'govuk-task-list' }.freeze
      end
    end
  end
end
