require_relative '../../base'
require_relative 'row/key'
require_relative 'row/value'
require_relative 'row/actions'

module CCS::Components
  module GovUK
    class SummaryList < Base
      # = GOV.UK Summary list row
      #
      # Generates the HTML for a summary list row
      #
      # @!attribute [r] key
      #   @return [Key] Initialised summary list cell for the key
      # @!attribute [r] value
      #   @return [Value] Initialised summary list cell for the value
      # @!attribute [r] actions
      #   @return [Actions] Initialised summary list cell for the actions

      class Row < Base
        private

        attr_reader :key, :value, :actions

        public

        # @param any_row_has_actions [Boolean] flag to indicate if any rows have actions
        # @param key [Hash] attributes for the key, see {CCS::Components::GovUK::SummaryList::Row::Key#initialize Key#initialize} for more details.
        # @param value [Hash] attributes for the value, see {CCS::Components::GovUK::SummaryList::Row::Value#initialize Value#initialize} for more details.
        # @param actions [Hash] attributes for the actions, see {CCS::Components::GovUK::SummaryList::Row::Actions#initialize Actions#initialize} for more details.
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the summary list row HTML

        def initialize(any_row_has_actions:, key:, value:, actions: nil, **options)
          super(**options)

          @options[:attributes][:class] << ' govuk-summary-list__row--no-actions' if any_row_has_actions && !actions

          @key = Key.new(context: @context, **key)
          @value = Value.new(context: @context, **value)
          @actions = Actions.new(context: @context, **actions) if actions
        end

        # Generates the HTML for the GOV.UK Summary list row
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(class: options[:attributes][:class]) do
            concat(key.render)
            concat(value.render)
            concat(actions.render) if actions
          end
        end

        # The default attributes for the summary list row

        DEFAULT_ATTRIBUTES = { class: 'govuk-summary-list__row' }.freeze
      end
    end
  end
end
