# frozen_string_literal: true

require_relative '../field'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      module Field
        # = GOV.UK Textarea
        #
        # This helper is used for generating the textarea component from the
        # {https://design-system.service.gov.uk/components/textarea GDS - Components - Textarea}
        #
        # This is considered a Field module and so makes use of the methods in {CCS::FrontendHelpers::GovUKFrontend::Field}

        module Textarea
          include Field

          # Generates the HTML for the GOV.UK textarea component
          #
          # @param attribute [String, Symbol] the attribute of the textarea
          # @param govuk_textarea_options [Hash] options that will be used for the parts of the form group, label, hint and textarea
          #
          # @option govuk_textarea_options [String] :error_message (nil) the error message to be displayed
          # @option govuk_textarea_options [ActiveModel] :model (nil) optional model that can be used to find an error message
          # @option govuk_textarea_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
          #                                                                         the textarea tag and find the error message
          # @option govuk_textarea_options [Hash] :form_group see {govuk_field}
          # @option govuk_textarea_options [Hash] :label see {govuk_field}
          # @option govuk_textarea_options [Hash] :hint see {govuk_field}
          # @option govuk_textarea_options [Hash] :textarea ({}) the options that will be used when rendering the textarea.
          #                                                      See {set_govuk_textarea_field_options} for more details.
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK textarea
          #                                     which can then be rendered on the page

          def govuk_textarea(attribute, **govuk_textarea_options)
            govuk_field(:textarea, attribute, **govuk_textarea_options) do |govuk_field_options, error_message|
              set_govuk_textarea_field_options(error_message, govuk_field_options)
              (govuk_textarea_options[:textarea] ||= {})[:content] = govuk_textarea_options[:model].send(attribute) if govuk_textarea_options[:model]

              concat(
                if govuk_textarea_options[:form]
                  govuk_textarea_form(govuk_textarea_options[:form], attribute, **govuk_field_options)
                else
                  govuk_textarea_tag(attribute, **govuk_field_options)
                end
              )
            end
          end

          private

          # Generates the textarea HTML for {govuk_textarea}
          #
          # @param attribute [String, Symbol] the attribute of the textarea
          # @param govuk_text_textarea_options [Hash] options that will be used in customising the HTML
          #
          # @option (see set_govuk_textarea_field_options)
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the textarea field which is used in {govuk_textarea}

          def govuk_textarea_tag(attribute, **govuk_text_textarea_options)
            text_area_tag(
              attribute,
              govuk_text_textarea_options[:content],
              **govuk_text_textarea_options[:attributes]
            )
          end

          # Generates the textarea HTML for {govuk_textarea} when there is a ActionView::Helpers::FormBuilder
          #
          # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the textarea
          # @param (see govuk_textarea_tag)
          #
          # @option (see set_govuk_textarea_field_options)
          #
          # @return (see govuk_textarea_tag)

          def govuk_textarea_form(form, attribute, **govuk_text_textarea_options)
            form.text_area(
              attribute,
              **govuk_text_textarea_options[:attributes]
            )
          end

          # Initialises the attributes for the textarea input
          #
          # @param error_message [String] used to indicate if there is an error which will add extra classes
          # @param govuk_text_textarea_options [Hash] options that will be used in customising the HTML
          #
          # @option govuk_text_textarea_options [String] :classes additional CSS classes for the textarea HTML
          # @option govuk_text_textarea_options [String] :content (nil) the content of the textarea
          # @option govuk_text_textarea_options [String] :rows (5) the number of rows for the text area
          # @option govuk_text_textarea_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

          def set_govuk_textarea_field_options(error_message, govuk_text_textarea_options)
            initialise_attributes_and_set_classes(govuk_text_textarea_options, "govuk-textarea #{'govuk-textarea--error' if error_message}".rstrip)

            govuk_text_textarea_options[:attributes][:rows] ||= govuk_text_textarea_options[:rows] || 5
          end
        end
      end
    end
  end
end
