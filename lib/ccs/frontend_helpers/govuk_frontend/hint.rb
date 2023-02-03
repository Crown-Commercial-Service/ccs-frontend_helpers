# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Hint
      #
      # This helper is used for generating the hint text component from the Government Design Systems

      module Hint
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper

        # Generates the HTML for the GOV.UK Hint component
        #
        # @param hint_text [String]  the hint text
        # @param govuk_hint_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_hint_options [String] :classes additional CSS classes for the hint HTML
        # @option govuk_hint_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Hint
        #                                     which can then be rendered on the page

        def govuk_hint(hint_text, **govuk_hint_options)
          initialise_attributes_and_set_classes(govuk_hint_options, 'govuk-hint')

          tag.div(hint_text, **govuk_hint_options[:attributes])
        end
      end
    end
  end
end
