require_relative '../base'

module CCS
  module Components
    module GovUK
      # = GOV.UK Tag
      #
      # This is used to generate the tag component from the
      # {https://design-system.service.gov.uk/components/tag GDS - Components - Tag}
      #
      # @!attribute [r] text
      #   @return [String] Text for the tag

      class Tag < Base
        private

        attr_reader :text

        public

        # @param text [String] the text for the tag
        # @param colour [String] optional colour for the tag,
        #                        see {https://design-system.service.gov.uk/components/tag/#additional-colours Tag - Additional colours}
        #                        for available colours in GOV.UK Frontend
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the tag HTML
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(text:, colour: nil, **options)
          super(**options)
          @options[:attributes][:class][..8] = "govuk-tag govuk-tag--#{colour}" if colour

          @text = text
        end

        # Generates the HTML for the GOV.UK Tag component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.strong(text, **options[:attributes])
        end

        # The default attributes for the tag

        DEFAULT_ATTRIBUTES = { class: 'govuk-tag' }.freeze
      end
    end
  end
end
