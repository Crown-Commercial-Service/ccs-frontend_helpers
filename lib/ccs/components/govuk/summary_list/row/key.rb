require_relative '../../../base'

module CCS
  module Components
    module GovUK
      class SummaryList < Base
        class Row < Base
          # = GOV.UK Summary list row key
          #
          # @!attribute [r] text
          #   @return [String] Text for the summary list row key

          class Key < Base
            private

            attr_reader :text

            public

            # @param text [String] Text for the summary list row key
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the summary list row key HTML

            def initialize(text:, **)
              super(**)

              @text = text
            end

            # Generates the HTML for the GOV.UK Summary list row key
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.dt(text, class: @options[:attributes][:class])
            end

            # The default attributes for the summary list row key

            DEFAULT_ATTRIBUTES = { class: 'govuk-summary-list__key' }.freeze
          end
        end
      end
    end
  end
end
