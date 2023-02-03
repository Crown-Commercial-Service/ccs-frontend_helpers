# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Warning text
      #
      # This helper is used for generating the warning text component from the
      # {https://design-system.service.gov.uk/components/warning-text GDS - Components - Warning text}

      module WarningText
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK Warning text component
        #
        # @param text [String] (nil) the text for the warning
        # @param govuk_warning_text_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_warning_text_options [String] :classes additional CSS classes for the tag HTML
        # @option govuk_warning_text_options [String] :icon_fallback_text the fallback text for the icon (default: +'Warning'+)
        # @option govuk_warning_text_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @yield HTML that will be used in the warning text. Ignored if text is passed.
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Warning text
        #                                     which can then be rendered on the page

        def govuk_warning_text(text = nil, **govuk_warning_text_options)
          initialise_attributes_and_set_classes(govuk_warning_text_options, 'govuk-warning-text')

          tag.div(**govuk_warning_text_options[:attributes]) do
            concat(tag.span('!', class: 'govuk-warning-text__icon'))
            concat(tag.strong(class: 'govuk-warning-text__text') do
              concat(tag.span(govuk_warning_text_options[:icon_fallback_text] || 'Warning', class: 'govuk-warning-text__assistive'))
              if text
                concat(text)
              else
                yield
              end
            end)
          end
        end
      end
    end
  end
end
