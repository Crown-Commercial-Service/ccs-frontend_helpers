require_relative '../base'

module CCS
  module Components
    module GovUK
      # = GOV.UK Back Link
      #
      # This is used to generate the back link component from the
      # {https://design-system.service.gov.uk/components/back-link GDS - Components - Back link}
      #
      # @!attribute [r] text
      #   @return [String] Text for the back link
      # @!attribute [r] href
      #   @return [String] The href for the back link

      class BackLink < Base
        private

        attr_reader :text, :href

        public

        # @param text [String] the text for the back link
        # @param href [String] the href for the back link
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the back link HTML
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(text:, href:, **options)
          super(**options)

          @text = text
          @href = href
        end

        # Generates the HTML for the GOV.UK Back link component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          link_to(text, href, **options[:attributes])
        end

        # The default attributes for the back link

        DEFAULT_ATTRIBUTES = { class: 'govuk-back-link' }.freeze
      end
    end
  end
end
