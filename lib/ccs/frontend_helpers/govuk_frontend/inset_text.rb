# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Inset Text
      #
      # This helper is used for generating the inset text component from the
      # {https://design-system.service.gov.uk/components/inset-text GDS - Components - Inset text}

      module InsetText
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK Inset text component
        #
        # @param inset_text [String] text to use within the inset text component
        # @param govuk_inset_text_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_inset_text_options [String] :classes additional CSS classes for the inset text HTML
        # @option govuk_inset_text_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @yield HTML that will be contained within the inset text div. Ignored if inset text is given
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Inset text
        #                                     which can then be rendered on the page

        def govuk_inset_text(inset_text = nil, **govuk_inset_text_options)
          initialise_attributes_and_set_classes(govuk_inset_text_options, 'govuk-inset-text')

          tag.div(**govuk_inset_text_options[:attributes]) do
            inset_text || yield
          end
        end
      end
    end
  end
end
