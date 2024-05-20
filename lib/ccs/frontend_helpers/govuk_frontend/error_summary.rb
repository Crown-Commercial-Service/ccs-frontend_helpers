# frozen_string_literal: true

require_relative '../../components/govuk/error_summary'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Error Summary
      #
      # This helper is used for generating the error summary component from the
      # {https://design-system.service.gov.uk/components/error-summary GDS - Components - Error summary}

      module ErrorSummary
        # Generates the HTML for the GOV.UK Error summary component
        #
        # @param (see CCS::Components::GovUK::ErrorSummary#initialize)
        #
        # @option (see CCS::Components::GovUK::ErrorSummary#initialize)
        #
        # @return (see CCS::Components::GovUK::ErrorSummary#render)

        def govuk_error_summary(title, error_summary_items = [], description = nil, **options)
          Components::GovUK::ErrorSummary.new(context: self, title: title, error_summary_items: error_summary_items, description: description, **options).render
        end

        # Generates the HTML for the GOV.UK Error summary component using the error messages in an ActiveModel
        #
        # @param model [ActiveModel] model that will be used to find the error messages to list
        # @param title [String] text to use for the heading of the error summary block
        # @param description [String] (nil) optional text to use for the description of the errors
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option (see CCS::Components::GovUK::ErrorSummary#initialize)
        #
        # @return [NilClass, ActiveSupport::SafeBuffer] if error messages are not on the model it will return nil,
        #                                               otherwise it returns the error summary HTML.

        def govuk_error_summary_with_model(model, title, description = nil, **options)
          return if model.errors.blank?

          error_summary_items = model.errors.map { |error| { text: error.message, href: "##{error.attribute}-error" } }

          Components::GovUK::ErrorSummary.new(context: self, title: title, error_summary_items: error_summary_items, description: description, **options).render
        end
      end
    end
  end
end
