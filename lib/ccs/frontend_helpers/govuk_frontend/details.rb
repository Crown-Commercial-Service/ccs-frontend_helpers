# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Details
      #
      # This helper is used for generating the details component from the
      # {https://design-system.service.gov.uk/components/details GDS - Components - Details}

      module Details
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK Details component
        #
        # @param summary_text [String] the summary text for the details element
        # @param govuk_details_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_details_options [String] :classes additional CSS classes for the details HTML
        # @option govuk_details_options [Hash] :attributes ({ data: { module: 'govuk-details' } }) any additional attributes that will added as part of the HTML
        #
        # @yield HTML that will be contained within the 'govuk-details__text' div
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Details
        #                                     which can then be rendered on the page

        def govuk_details(summary_text, **govuk_details_options, &block)
          initialise_attributes_and_set_classes(govuk_details_options, 'govuk-details')
          set_data_module(govuk_details_options, 'govuk-details')

          tag.details(**govuk_details_options[:attributes]) do
            concat(tag.summary(tag.span(summary_text, class: 'govuk-details__summary-text'), class: 'govuk-details__summary'))
            concat(tag.div(class: 'govuk-details__text', &block))
          end
        end
      end
    end
  end
end
