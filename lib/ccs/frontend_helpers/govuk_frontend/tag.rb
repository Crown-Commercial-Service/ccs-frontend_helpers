# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Tag
      #
      # This helper is used for generating the tag component from the
      # {https://design-system.service.gov.uk/components/tag GDS - Components - Tag}

      module Tag
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper

        # Generates the HTML for the GOV.UK Tag component
        #
        # @param text [String] the text for the tag
        # @param colour [String] optional colour for the tag,
        #                        see {https://design-system.service.gov.uk/components/tag/#additional-colours Tag - Additional colours}
        #                        for available colours in GOV.UK Frontend
        # @param govuk_tag_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_tag_options [String] :classes additional CSS classes for the tag HTML
        # @option govuk_tag_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Tag
        #                                     which can then be rendered on the page

        def govuk_tag(text, colour = nil, **govuk_tag_options)
          initialise_attributes_and_set_classes(govuk_tag_options, "govuk-tag #{"govuk-tag--#{colour}" if colour}".rstrip)

          tag.strong(text, govuk_tag_options[:attributes])
        end
      end
    end
  end
end
