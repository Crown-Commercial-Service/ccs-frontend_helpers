# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Error Message
      #
      # This helper is used for generating the error message component from the
      # {https://design-system.service.gov.uk/components/error-message GDS - Components - Error message}

      module ErrorMessage
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK Error message component
        #
        # @param message [String] the message to be displayed
        # @param attribute [String, Symbol] the attribute that has an error
        # @param govuk_error_message_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_error_message_options [String] :classes additional CSS classes for the error message HTML
        # @option govuk_error_message_options [String] :visually_hidden_text ('Error') visualy hidden text before the error message
        # @option govuk_error_message_options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Error message
        #                                     which can then be rendered on the page

        def govuk_error_message(message, attribute, **govuk_error_message_options)
          initialise_attributes_and_set_classes(govuk_error_message_options, 'govuk-error-message')

          govuk_error_message_options[:attributes][:id] ||= "#{attribute}-error"
          visually_hidden_text = govuk_error_message_options[:visually_hidden_text] || 'Error'

          tag.p(**govuk_error_message_options[:attributes]) do
            concat(tag.span("#{visually_hidden_text}: ", class: 'govuk-visually-hidden')) if visually_hidden_text.present?
            concat(message)
          end
        end

        # Generates the HTML for the GOV.UK Error message component using the error messages in an ActiveModel
        #
        # @param model [ActiveModel] model that will be used to find the error message
        # @param attribute [String, Symbol] the attribute that has an error
        # @param govuk_error_message_options [Hash] options that will be used in customising the HTML
        #
        # @option (see #govuk_error_message)
        #
        # @return [NilClass, ActiveSupport::SafeBuffer] if the error message is not on the model it will return nil,
        #                                               otherwise the HTML for the GOV.UK Error message
        #                                               which can then be rendered on the page is returned

        def govuk_error_message_with_model(model, attribute, **govuk_error_message_options)
          error_message = model.errors[attribute].first
          return unless error_message

          govuk_error_message(error_message, attribute, **govuk_error_message_options)
        end
      end
    end
  end
end
