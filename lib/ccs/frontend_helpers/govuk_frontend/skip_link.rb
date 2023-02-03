# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Skip Link
      #
      # This helper is used for generating the skip link component from the
      # {https://design-system.service.gov.uk/components/skip-link GDS - Components - Skip link}

      module SkipLink
        include SharedMethods
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the GOV.UK Skip link component
        #
        # @param text [String] the text for the skip link
        # @param href [String] the href for the skip link
        # @param govuk_skip_link_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_skip_link_options [String] :classes additional CSS classes for the skip link HTML
        # @option govuk_skip_link_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Skip link
        #                                     which can then be rendered on the page

        def govuk_skip_link(text, href = '#content', **govuk_skip_link_options)
          initialise_attributes_and_set_classes(govuk_skip_link_options, 'govuk-skip-link')
          set_data_module(govuk_skip_link_options, 'govuk-skip-link')

          link_to(text, href, **govuk_skip_link_options[:attributes])
        end
      end
    end
  end
end
