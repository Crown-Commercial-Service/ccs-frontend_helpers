# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Back Link
      #
      # This helper is used for generating the back link component from the
      # {https://design-system.service.gov.uk/components/back-link GDS - Components - Back link}

      module BackLink
        include SharedMethods
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the GOV.UK Back link component
        #
        # @param text [String] the text for the back link
        # @param href [String] the href for the back link
        # @param govuk_back_link_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_back_link_options [String] :classes additional CSS classes for the back link HTML
        # @option govuk_back_link_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Back link
        #                                     which can then be rendered on the page

        def govuk_back_link(text, href, **govuk_back_link_options)
          initialise_attributes_and_set_classes(govuk_back_link_options, 'govuk-back-link')

          link_to(text, href, **govuk_back_link_options[:attributes])
        end
      end
    end
  end
end
