require_relative '../base'
require_relative 'summary_list/row'
require_relative 'summary_list/card'

module CCS
  module Components
    module GovUK
      # = GOV.UK Summary list
      #
      # This is used for generating the summary list component from the
      # {https://design-system.service.gov.uk/components/summary-list GDS - Components - Summary list}
      #
      # @!attribute [r] summary_list_rows
      #   @return [Array<Row>] An array of the initialised summary list rows
      # @!attribute [r] card
      #   @return [Card] Initialised summary list card

      class SummaryList < Base
        private

        attr_reader :summary_list_rows, :card

        public

        # @param summary_list_items [Array<Hash>] An array of options for the summary list rows.
        #                                         See {Components::GovUK::SummaryList::Row#initialize Row#initialize} for details of the items in the array.
        # @param card [Hash] attributes for the card, see {CCS::Components::GovUK::SummaryList::Card#initialize Card#initialize} for more details.
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the summary list HTML
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

        def initialize(summary_list_items:, card: nil, **options)
          super(**options)

          any_row_has_actions = summary_list_items.any? { |summary_list_item| summary_list_item[:actions].present? }

          @summary_list_rows = summary_list_items.map { |summary_list_item| Row.new(any_row_has_actions: any_row_has_actions, context: @context, **summary_list_item) }
          @card = Card.new(context: @context, **card) if card
        end

        # Generates the HTML for the GOV.UK Summary list component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          if card
            card.render do
              render_summary_list
            end
          else
            render_summary_list
          end
        end

        # The default attributes for the summary list

        DEFAULT_ATTRIBUTES = { class: 'govuk-summary-list' }.freeze

        private

        # Generates the HTML for the actual summary list
        #
        # @return [ActiveSupport::SafeBuffer]

        def render_summary_list
          tag.dl(**options[:attributes]) do
            summary_list_rows.each { |summary_list_row| concat(summary_list_row.render) }
          end
        end
      end
    end
  end
end
