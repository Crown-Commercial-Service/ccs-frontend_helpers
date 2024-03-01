require_relative '../../../base'
require_relative '../action/link'

module CCS
  module Components
    module GovUK
      class SummaryList < Base
        class Card < Base
          # = GOV.UK Summary list card actions
          #
          # @!attribute [r] action_links
          #   @return [Array<Action::Link>] An array of the initialised aummary list card action links

          class Actions < Base
            private

            attr_reader :action_links

            public

            # @param items [Array<Hash>] An array of attributes for the action links.
            #                            See {Components::GovUK::SummaryList::Action::Link#initialize Action::Link#initialize} for details of the items in the array.
            # @param card_title [String] the text for the card title
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the summary list card actions HTML

            def initialize(items:, card_title:, **options)
              super(**options)

              @action_links = items.map { |item| Action::Link.new(context: @context, card_title: card_title, **item) }
            end

            # Generates the HTML for the GOV.UK Summary list card actions
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              if action_links.length == 1
                tag.div(class: @options[:attributes][:class]) do
                  action_links.first.render
                end
              else
                tag.ul(class: @options[:attributes][:class]) do
                  action_links.each do |action_link|
                    concat(tag.li(action_link.render, class: 'govuk-summary-card__action'))
                  end
                end
              end
            end

            # The default attributes for the summary list card actions

            DEFAULT_ATTRIBUTES = { class: 'govuk-summary-card__actions' }.freeze
          end
        end
      end
    end
  end
end
