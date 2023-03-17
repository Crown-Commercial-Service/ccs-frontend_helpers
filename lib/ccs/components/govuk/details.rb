require_relative '../base'

module CCS::Components
  module GovUK
    # = GOV.UK Details
    #
    # This is used to generate the details component from the
    # {https://design-system.service.gov.uk/components/details GDS - Components - Details}
    #
    # @!attribute [r] summary_text
    #   @return [String] Summary text for the details element

    class Details < Base
      private

      attr_reader :summary_text

      public

      # @param summary_text [String] the summary text for the details element
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the details HTML
      # @option options [Hash] :attributes ({ data: { module: 'govuk-details' } }) any additional attributes that will added as part of the HTML

      def initialize(summary_text:, **options)
        super(**options)

        @summary_text = summary_text
      end

      # Generates the HTML for the GOV.UK Details component
      #
      # @yield HTML that will be contained within the 'govuk-details__text' div
      #
      # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Details
      #                                     which can then be rendered on the page

      def render(&block)
        tag.details(**options[:attributes]) do
          concat(tag.summary(tag.span(summary_text, class: 'govuk-details__summary-text'), class: 'govuk-details__summary'))
          concat(tag.div(class: 'govuk-details__text', &block))
        end
      end

      # The default attributes for the details

      DEFAULT_ATTRIBUTES = { class: 'govuk-details', data: { module: 'govuk-details' } }.freeze
    end
  end
end
