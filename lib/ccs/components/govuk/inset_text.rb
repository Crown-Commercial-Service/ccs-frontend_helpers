require_relative '../base'

module CCS::Components
  module GovUK
    # = GOV.UK Inset Text
    #
    # This is used to generate the inset text component from the
    # {https://design-system.service.gov.uk/components/inset-text GDS - Components - Inset text}
    #
    # @!attribute [r] text
    #   @return [String] Text for the inset text

    class InsetText < Base
      private

      attr_reader :text

      public

      # @param text [String] text to use within the inset text component.
      #                      If nil, then a block will be rendered
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the inset text HTML
      # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

      def initialize(text: nil, **options)
        super(**options)

        @text = text
      end

      # Generates the HTML for the GOV.UK Inset text component
      #
      # @yield HTML that will be contained within the inset text div. Ignored if inset text is given
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          text || yield
        end
      end

      # The default attributes for the inset text

      DEFAULT_ATTRIBUTES = { class: 'govuk-inset-text' }.freeze
    end
  end
end
