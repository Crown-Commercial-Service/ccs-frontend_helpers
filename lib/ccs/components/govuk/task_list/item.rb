require_relative '../../base'
require_relative 'item/title'
require_relative 'item/status'

module CCS
  module Components
    module GovUK
      class TaskList < Base
        # = GOV.UK Task list item
        #
        # The individual list item for the task list
        #
        # @!attribute [r] title
        #   @return [Title] Initialised task list item title
        # @!attribute [r] status
        #   @return [Status] Initialised task list item status
        # @!attribute [r] hint_text
        #   @return [String] optional hint text for the item
        # @!attribute [r] id_prefix
        #   @return [String] ID prefix for the task list item

        class Item < Base
          private

          attr_reader :id_prefix, :title, :hint_text, :status

          public

          # rubocop:disable Metrics/ParameterLists

          # @param title [Hash] options for the item title.
          #                     See {Components::GovUK::TaskList::Item::Title#initialize Title#initialize} for details of title.
          # @param status [Hash] options for the item status.
          #                     See {Components::GovUK::TaskList::Item::Status#initialize Status#initialize} for details of status.
          # @param index [Integer] the index of the item
          # @param id_prefix [String] the id prefix for the task list
          # @param hint_text [String] optional hint text for the item
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [String] :classes additional CSS classes for the task list item HTML

          def initialize(title:, status:, index:, id_prefix:, hint_text: nil, **)
            super(**)
            @options[:attributes][:class] << ' govuk-task-list__item--with-link' if title[:href]

            @id_prefix = "#{id_prefix}-#{index}"
            @title = Title.new(context: @context, id_prefix: @id_prefix, hint_text: hint_text, **title)
            @hint_text = hint_text
            @status = Status.new(context: @context, id_prefix: @id_prefix, **status)
          end

          # rubocop:enable Metrics/ParameterLists

          # Generates the HTML for the GOV.UK Task list item
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.li(class: options[:attributes][:class]) do
              concat(tag.div(class: 'govuk-task-list__name-and-hint') do
                concat(title.render)
                concat(tag.div(hint_text, class: 'govuk-task-list__hint', id: "#{id_prefix}-hint")) if hint_text
              end)
              concat(status.render)
            end
          end

          # The default attributes for the task list item

          DEFAULT_ATTRIBUTES = { class: 'govuk-task-list__item' }.freeze
        end
      end
    end
  end
end
