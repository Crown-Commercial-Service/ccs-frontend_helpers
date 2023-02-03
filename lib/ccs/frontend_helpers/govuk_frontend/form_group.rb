# frozen_string_literal: true

require_relative 'error_message'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK FormGroup
      #
      # This helper is used for generating the form group component from the Government Design Systems

      module FormGroup
        include ErrorMessage

        # Generates the HTML for the GOV.UK Form Group component
        #
        # @param attribute [String, Symbol] the attribute that the form group is for
        # @param govuk_form_group_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_form_group_options [String] :classes additional CSS classes for the form group HTML
        # @option govuk_form_group_options [String] :error_message (nil) the error message to be displayed
        # @option govuk_form_group_options [ActiveModel] :model (nil) model that will be used to find an error message
        # @option govuk_form_group_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @yield HTML that will be contained within the 'govuk-form-group' div
        #
        # @yieldparam displayed_error_message [ActiveSupport::SafeBuffer] the HTML for the error message (if there is one)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Form Group
        #                                     which can then be rendered on the page

        def govuk_form_group(attribute, **govuk_form_group_options)
          error_message = if govuk_form_group_options[:model]
                            model.errors[attribute].first
                          else
                            govuk_form_group_options[:error_message]
                          end

          initialise_attributes_and_set_classes(govuk_form_group_options, "govuk-form-group #{'govuk-form-group--error' if error_message}".rstrip)

          govuk_form_group_options[:attributes][:id] ||= "#{attribute}-form-group"

          tag.div(**govuk_form_group_options[:attributes]) do
            yield((govuk_error_message(error_message, attribute) if error_message))
          end
        end
      end
    end
  end
end
