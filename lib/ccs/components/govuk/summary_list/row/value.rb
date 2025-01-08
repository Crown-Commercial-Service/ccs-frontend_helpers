require_relative '../../../base'

module CCS
  module Components
    module GovUK
      class SummaryList < Base
        class Row < Base
          # = GOV.UK Summary list row value
          #
          # @!attribute [r] text
          #   @return [String] Text for the summary list row value

          class Value < Base
            private

            attr_reader :text

            public

            # @param text [String] Text for the summary list row value
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the summary list row value HTML

            def initialize(text:, **)
              super(**)

              @text = text
            end

            # Generates the HTML for the GOV.UK Summary list row value
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.dd(text, class: @options[:attributes][:class])
            end

            # The default attributes for the summary list row value

            DEFAULT_ATTRIBUTES = { class: 'govuk-summary-list__value' }.freeze
          end
        end
      end
    end
  end
end
