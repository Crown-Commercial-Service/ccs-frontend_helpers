# frozen_string_literal: true

require_relative '../field'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      module Field
        # = GOV.UK Input
        #
        # This helper is used for generating the input component from the
        # {https://design-system.service.gov.uk/components/text-input GDS - Components - Text Input}
        #
        # This is considered a Field module and so makes use of the methods in {CCS::FrontendHelpers::GovUKFrontend::Field}

        module Input
          include Field

          # Generates the HTML for the GOV.UK input component
          #
          # @param attribute [String, Symbol] the attribute of the input
          # @param govuk_input_options [Hash] options that will be used for the parts of the form group, label, hint and input
          #
          # @option govuk_input_options [String] :error_message (nil) the error message to be displayed
          # @option govuk_input_options [ActiveModel] :model (nil) optional model that can be used to find an error message
          # @option govuk_label_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
          #                                                                      the input tag and find the error message
          # @option govuk_input_options [Hash] :form_group see {govuk_field}
          # @option govuk_input_options [Hash] :label see {govuk_field}
          # @option govuk_input_options [Hash] :hint see {govuk_field}
          # @option govuk_input_options [Hash] :input ({}) the options that will be used when rendering the input.
          #                                                See {_govuk_input_field} for more details.
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Input
          #                                     which can then be rendered on the page

          def govuk_input(attribute, **govuk_input_options)
            govuk_field(:input, attribute, **govuk_input_options) do |govuk_field_options, error_message|
              concat(_govuk_input_field(error_message, **govuk_field_options) do
                field_type = get_field_type(govuk_field_options[:field_type])
                govuk_field_options[:value] = govuk_input_options[:model].send(attribute) if govuk_input_options[:model]

                if govuk_input_options[:form]
                  govuk_input_form(govuk_input_options[:form], field_type, attribute, **govuk_field_options)
                else
                  govuk_input_tag(field_type, attribute, **govuk_field_options)
                end
              end)
            end
          end

          private

          # Generates the input HTML for {govuk_input}
          #
          # @param field_type [String] the inout field type
          # @param attribute [String, Symbol] the attribute of the input
          # @param govuk_text_input_options [Hash] options that will be used in customising the HTML
          #
          # @option (see _govuk_input_field)
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the input field which is used in {govuk_input}

          def govuk_input_tag(field_type, attribute, **govuk_text_input_options)
            send("#{field_type}_tag", attribute, govuk_text_input_options[:value], **govuk_text_input_options[:attributes])
          end

          # Generates the input HTML for {govuk_input} when there is a ActionView::Helpers::FormBuilder
          #
          # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the input tag
          # @param (see govuk_input_tag)
          #
          # @option (see _govuk_input_field)
          #
          # @return (see govuk_input_tag)

          def govuk_input_form(form, field_type, attribute, **govuk_text_input_options)
            form.send(field_type, attribute, **govuk_text_input_options[:attributes])
          end

          # Wrapper method used by {govuk_input} to generate the Input HTML
          #
          # @param error_message [String] used to indicate if there is an error which will add extra classes
          # @param govuk_text_input_options [Hash] options that will be used in customising the HTML
          #
          # @option govuk_text_input_options [String] :classes additional CSS classes for the input HTML
          # @option govuk_text_input_options [String] :value (nil) the value of the input
          # @option govuk_text_input_options [Symbol] :field_type the type of the input field, see {get_field_type} for options
          # @option govuk_text_input_options [Hash] :prefix (nil) optional prefix for the input field. See {govuk_fix} for more details.
          # @option govuk_text_input_options [Hash] :suffix (nil) optional suffix for the input field. See {govuk_fix} for more details.
          # @option govuk_text_input_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
          #
          # @yield the input HTML generated by {govuk_input_tag} or {govuk_input_form}
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the input field which is used by {govuk_input}

          def _govuk_input_field(error_message, **govuk_text_input_options)
            initialise_attributes_and_set_classes(govuk_text_input_options, "govuk-input #{'govuk-input--error' if error_message}".rstrip)

            input_html = yield

            prefix = govuk_text_input_options[:prefix]
            suffix = govuk_text_input_options[:suffix]

            if prefix || suffix
              tag.div(class: 'govuk-input__wrapper') do
                concat(govuk_fix('pre', prefix)) if prefix
                concat(input_html)
                concat(govuk_fix('suf', suffix)) if suffix
              end
            else
              input_html
            end
          end

          # Generates the prefix and suffix HTML for {_govuk_input_field}
          #
          # @param fix [String] either +"pre"+ or +"suf"+
          # @param govuk_fix_options [Hash] options that will be used in customising the HTML
          #
          # @option govuk_fix_options [String] :classes additional CSS classes for the input HTML
          # @option govuk_text_input_options [Hash] :attributes ({ aria: { hidden: true } }) any additional attributes that will added as part of the HTML
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the input field which is used in {_govuk_input_field}

          def govuk_fix(fix, govuk_fix_options)
            initialise_attributes_and_set_classes(govuk_fix_options, "govuk-input__#{fix}fix")

            (govuk_fix_options[:attributes][:aria] ||= {})[:hidden] = true

            tag.div(govuk_fix_options[:text], **govuk_fix_options[:attributes])
          end

          # Returns the field type used to create the rails input tag
          #
          # @param field_type [Symbol] the type of the field, defaults to text
          #                            Allowed values are:
          #                            - +:email+
          #                            - +:password+

          def get_field_type(field_type)
            case field_type
            when :email, :password
              :"#{field_type}_field"
            else
              :text_field
            end
          end
        end
      end
    end
  end
end
