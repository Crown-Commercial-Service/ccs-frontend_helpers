require_relative '../../../base'

module CCS
  module Components
    module GovUK
      class SummaryList < Base
        class Card < Base
          # = GOV.UK Summary list card title
          #
          # @!attribute [r] text
          #   @return [String] Text for the title
          # @!attribute [r] heading_level
          #   @return [String] Heading level for the title

          class Title < Base
            private

            attr_reader :text, :heading_level

            public

            # @param text [String] the text for the title
            # @param heading_level [String] heading level, from 1 to 6
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the summary list card title HTML

            def initialize(text:, heading_level: '2', **options)
              super(**options)

              @text = text
              @heading_level = heading_level
            end

            # Generates the HTML for the GOV.UK Summary list card title
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.send("h#{heading_level}", text, class: @options[:attributes][:class])
            end

            # The default attributes for the summary list card title

            DEFAULT_ATTRIBUTES = { class: 'govuk-summary-card__title' }.freeze
          end
        end
      end
    end
  end
end
