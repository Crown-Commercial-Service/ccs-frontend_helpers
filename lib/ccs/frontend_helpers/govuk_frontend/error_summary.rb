# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Error Summary
      #
      # This helper is used for generating the error summary component from the
      # {https://design-system.service.gov.uk/components/error-summary GDS - Components - Error summary}

      module ErrorSummary
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the GOV.UK Error summary component
        #
        # @param title [String] text to use for the heading of the error summary block
        # @param error_list [Array] the list of errors to include in the summary. See {govuk_error_summary_list}
        # @param description [String] optional text to use for the description of the errors
        # @param govuk_error_summary_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_error_summary_options [String] :classes additional CSS classes for the error summary HTML
        # @option govuk_error_summary_options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Error summary
        #                                     which can then be rendered on the page

        def govuk_error_summary(title, error_list, description = nil, **govuk_error_summary_options)
          initialise_attributes_and_set_classes(govuk_error_summary_options, 'govuk-error-summary')
          set_data_module(govuk_error_summary_options, 'govuk-error-summary')

          tag.div(**govuk_error_summary_options[:attributes]) do
            tag.div(role: 'alert') do
              concat(tag.h2(title, class: 'govuk-error-summary__title'))
              concat(tag.div(class: 'govuk-error-summary__body') do
                concat(tag.p(description)) if description
                concat(govuk_error_summary_list(error_list))
              end)
            end
          end
        end

        # Generates the HTML for the GOV.UK Error summary component using the error messages in an ActiveModel
        #
        # @param model [ActiveModel] model that will be used to find the error messages to list
        # @param title [String] text to use for the heading of the error summary block
        # @param description [String] (nil) optional text to use for the description of the errors
        # @param govuk_error_summary_options [Hash] options that will be used in customising the HTML
        #
        # @option (see #govuk_error_summary)
        #
        # @return [NilClass, ActiveSupport::SafeBuffer] if there are no errors on the model it will return nil,
        #                                               otherwise the HTML for the GOV.UK Error summary
        #                                               which can then be rendered on the page is returned

        def govuk_error_summary_with_model(model, title, description = nil, **govuk_error_summary_options)
          return if model.errors.blank?

          error_list = model.errors.map { |error| { text: error.message, href: "##{error.attribute}-error" } }

          govuk_error_summary(title, error_list, description, **govuk_error_summary_options)
        end

        private

        # Generates the HTML for the error list in {govuk_error_summary}
        #
        # @param error_list [Array] The list of errors to include in the summary. See {#govuk_error_summary_list}
        #
        # @option error_list [String] :href href for the error link item. If provided item will be a link
        # @option error_list [String] :text Text for the error link item
        # @option error_list [Hash] :attributes ({}) any additional attributes that will be added as part of the link item
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the error list
        #                                     which is used in {govuk_error_summary}

        def govuk_error_summary_list(error_list)
          tag.ul(class: 'govuk-list govuk-error-summary__list') do
            error_list.each do |error|
              concat(tag.li do
                if error[:href]
                  link_to(error[:text], error[:href], **(error[:attributes] || {}))
                else
                  error[:text]
                end
              end)
            end
          end
        end
      end
    end
  end
end
