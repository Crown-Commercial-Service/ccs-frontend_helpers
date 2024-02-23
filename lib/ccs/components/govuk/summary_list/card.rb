require_relative '../../base'
require_relative 'card/title'
require_relative 'card/actions'

module CCS
  module Components
    module GovUK
      class SummaryList < Base
        # = GOV.UK Summary card
        #
        # This is used for generating the summary cards component from the
        # {https://design-system.service.gov.uk/components/summary-list/#summary-cards GDS - Components - Summary cards}
        #
        # @!attribute [r] title
        #   @return [Title] Initialised summary card title
        # @!attribute [r] actions
        #   @return [Actions] Initialised summary card actions

        class Card < Base
          private

          attr_reader :title, :actions

          public

          # @param title [Hash] attributes for the title, see {CCS::Components::GovUK::SummaryList::Card::Title#initialize Title#initialize} for more details.
          # @param actions [Hash] attributes for the actions, see {CCS::Components::GovUK::SummaryList::Card::Actions#initialize Actions#initialize} for more details.
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [String] :classes additional CSS classes for the summary card HTML
          # @option options [Hash] :attributes any additional attributes that will be added as part of the HTML

          def initialize(title: nil, actions: nil, **options)
            super(**options)

            @title = Title.new(context: @context, **title) if title
            @actions = Actions.new(context: @context, card_title: title&.dig(:text), **actions) if actions
          end

          # Generates the HTML for the GOV.UK Summary card
          #
          # @yield the HTML for the summary list
          #
          # @return [ActiveSupport::SafeBuffer]

          def render(&block)
            tag.div(**@options[:attributes]) do
              concat(tag.div(class: 'govuk-summary-card__title-wrapper') do
                concat(title.render) if title
                concat(actions.render) if actions
              end)
              concat(tag.div(class: 'govuk-summary-card__content', &block))
            end
          end

          # The default attributes for the summary card

          DEFAULT_ATTRIBUTES = { class: 'govuk-summary-card' }.freeze
        end
      end
    end
  end
end
