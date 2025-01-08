require_relative '../base'

module CCS
  module Components
    module GovUK
      # = GOV.UK Skip Link
      #
      # This is used to generate the skip link component from the
      # {https://design-system.service.gov.uk/components/skip-link GDS - Components - Skip link}
      #
      # @!attribute [r] text
      #   @return [String] Text for the skip link
      # @!attribute [r] href
      #   @return [String] The href for the skip link

      class SkipLink < Base
        private

        attr_reader :text, :href

        public

        # @param text [String] the text for the skip link
        # @param href [String] the href for the skip link
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the skip link HTML
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(text:, href: nil, **)
          super(**)

          @text = text
          @href = href || '#content'
        end

        # Generates the HTML for the GOV.UK Skip link component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          link_to(text, href, **options[:attributes])
        end

        # The default attributes for the skip link

        DEFAULT_ATTRIBUTES = { class: 'govuk-skip-link', data: { module: 'govuk-skip-link' } }.freeze
      end
    end
  end
end
