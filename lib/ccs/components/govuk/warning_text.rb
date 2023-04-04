require_relative '../base'

module CCS::Components
  module GovUK
    # = GOV.UK Warning text
    #
    # This helper is used for generating the warning text component from the
    # {https://design-system.service.gov.uk/components/warning-text GDS - Components - Warning text}
    #
    # @!attribute [r] text
    #   @return [String] Text for the warning text

    class WarningText < Base
      private

      attr_reader :text

      public

      # @param text [String] (nil) the text for the warning
      #                            If nil, then a block will be rendered
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the tag HTML
      # @option options [String] :icon_fallback_text the fallback text for the icon (default: +'Warning'+)
      # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

      def initialize(text: nil, **options)
        super(**options)

        @text = text
      end

      # Generates the HTML for the GOV.UK Warning text component
      #
      # @yield HTML that will be used in the warning text. Ignored if text is passed.
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          concat(tag.span('!', class: 'govuk-warning-text__icon'))
          concat(tag.strong(class: 'govuk-warning-text__text') do
            concat(tag.span(options[:icon_fallback_text] || 'Warning', class: 'govuk-warning-text__assistive'))
            if text
              concat(text)
            else
              yield
            end
          end)
        end
      end

      # The default attributes for the warning text

      DEFAULT_ATTRIBUTES = { class: 'govuk-warning-text' }.freeze
    end
  end
end
