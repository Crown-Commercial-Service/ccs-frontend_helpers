# frozen_string_literal: true

require_relative '../../components/govuk/back_link'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Error Message
    #
    # This helper is used for generating the error message component from the
    # {https://design-system.service.gov.uk/components/error-message GDS - Components - Error message}

    module ErrorMessage
      # Generates the HTML for the GOV.UK Error message component
      #
      # @param (see CCS::Components::GovUK::ErrorMessage#initialize)
      #
      # @option (see CCS::Components::GovUK::ErrorMessage#initialize)
      #
      # @return (see CCS::Components::GovUK::ErrorMessage#render)

      def govuk_error_message(error_message, attribute, **options)
        Components::GovUK::ErrorMessage.new(context: self, message: error_message, attribute: attribute, **options).render
      end

      # Generates the HTML for the GOV.UK Error message component using the error messages in an ActiveModel
      #
      # @param model [ActiveModel] model that will be used to find the error message
      # @param attribute [String, Symbol] the attribute that has an error
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option (see CCS::Components::GovUK::ErrorMessage#initialize)
      #
      # @return [NilClass, ActiveSupport::SafeBuffer] if the error message is not on the model it will return nil,
      #                                               otherwise it returns the error message HTML

      def govuk_error_message_with_model(model, attribute, **options)
        error_message = model.errors[attribute].first
        return unless error_message

        Components::GovUK::ErrorMessage.new(context: self, message: error_message, attribute: attribute, **options).render
      end
    end
  end
end
