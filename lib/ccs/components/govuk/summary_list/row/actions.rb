require_relative '../../../base'
require_relative '../action/link'

module CCS
  module Components
    module GovUK
      class SummaryList < Base
        class Row < Base
          # = GOV.UK Summary list row actions
          #
          # @!attribute [r] action_links
          #   @return [Array<Action::Link>] An array of the initialised aummary list row action links

          class Actions < Base
            private

            attr_reader :action_links

            public

            # @param items [Array<Hash>] An array of attributes for the action links.
            #                            See {Components::GovUK::SummaryList::Action::Link#initialize Action::Link#initialize} for details of the items in the array.
            # @param card_title [String] the text for the card title
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the summary list row actions HTML

            def initialize(items:, card_title: nil, **)
              super(**)

              @action_links = items.map { |item| Action::Link.new(card_title: card_title, context: @context, **item) }
            end

            # Generates the HTML for the GOV.UK Summary list row actions
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.dd(class: @options[:attributes][:class]) do
                if action_links.length == 1
                  action_links.first.render
                else
                  tag.ul(class: 'govuk-summary-list__actions-list') do
                    action_links.each do |action_link|
                      concat(tag.li(action_link.render, class: 'govuk-summary-list__actions-list-item'))
                    end
                  end
                end
              end
            end

            # The default attributes for the summary list row actions

            DEFAULT_ATTRIBUTES = { class: 'govuk-summary-list__actions' }.freeze
          end
        end
      end
    end
  end
end
