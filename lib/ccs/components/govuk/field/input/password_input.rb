require_relative 'text_input'
require_relative 'password_input/show_hide_button'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Input < Field
          # = GOV.UK Password input
          #
          # This is used for generating the password input component from the
          # {https://design-system.service.gov.uk/components/password-input GDS - Components - Password Input}
          #
          # @!attribute [r] text_input
          #   @return [CCS::Components::GovUK::Field::Input::TextInput] Initialised text input component

          class PasswordInput
            private

            attr_reader :text_input

            public

            # @param (see CCS::Components::GovUK::Field::Input::TextInput#initialize)
            #
            # @option (see CCS::Components::GovUK::Field::Input::TextInput#initialize)

            def initialize(attribute:, context:, **options)
              set_password_input_from_group_options(options)

              show_hide_button = ShowHideButton.new(attribute: attribute, context: context, after_input: options.delete(:after_input), **options)

              options[:attributes] ||= {}
              options[:attributes][:spellcheck] = false
              options[:attributes][:autocapitalize] = 'none'
              options[:attributes][:autocomplete] ||= 'current-password'

              @text_input = TextInput.new(
                context: context,
                attribute: attribute,
                after_input: show_hide_button.render,
                input_wrapper: {
                  classes: 'govuk-password-input__wrapper'
                },
                classes: "govuk-password-input__input govuk-js-password-input-input #{options.delete(:classes)}".rstrip,
                field_type: :password,
                **options
              )
            end

            delegate :render, to: :text_input

            private

            # rubocop:disable Naming/AccessorMethodName

            # Sets the password input form group options
            #
            # @param options [Hash] options for the password input
            #
            # @option options [String] :show_password_text button text when the password is hidden
            # @option options [String] :hide_password_text button text when the password is visible
            # @option options [String] :show_password_aria_label_text button text exposed to assistive technologies, like screen readers, when the password is hidden
            # @option options [String] :hide_password_aria_label_text button text exposed to assistive technologies, like screen readers, when the password is visible
            # @option options [String] :password_shown_announcement_text announcement made to screen reader users when their password has become visible in plain text
            # @option options [String] :password_hidden_announcement_text announcement made to screen reader users when their password has been obscured and is not visible

            def set_password_input_from_group_options(options)
              (options[:form_group] ||= {})[:classes] = "govuk-password-input #{options.dig(:form_group, :classes)}".rstrip
              ((options[:form_group][:attributes] ||= {})[:data] ||= {})[:module] = 'govuk-password-input'

              get_password_input_translations(options) do |data_attribute, value|
                options[:form_group][:attributes][:data][data_attribute] = value
              end
            end

            # rubocop:enable Naming/AccessorMethodName

            # Generator for the translation options for password input
            #
            # @param (see initialise_password_input_html_options)
            #
            # @option (see initialise_password_input_html_options)
            #
            # @yield Data attribute key and the value

            def get_password_input_translations(password_input_options)
              %i[show_password hide_password show_password_aria_label hide_password_aria_label password_shown_announcement password_hidden_announcement].each do |data_attribute|
                data_attribute_name = :"#{data_attribute}_text"

                next unless password_input_options[data_attribute_name]

                yield :"i18n.#{data_attribute.to_s.gsub('_', '-')}", password_input_options[data_attribute_name]
              end
            end
          end
        end
      end
    end
  end
end
