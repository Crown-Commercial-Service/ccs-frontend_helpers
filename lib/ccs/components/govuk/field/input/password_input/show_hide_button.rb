require_relative '../../../button'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Input < Field
          class PasswordInput
            # = GOV.UK Password input show/hide button
            #
            # This is used to generate the password input show/hide button
            #
            # @!attribute [r] show_hide_button
            #   @return [Button] Show/Hide button
            # @!attribute [r] after_input
            #   @return [String] Text or HTML for after the textarea input

            class ShowHideButton
              include ActionView::Context
              include ActionView::Helpers
              include ActionView::Helpers::FormTagHelper

              private

              attr_reader :show_hide_button, :after_input

              public

              # @param attribute [String] the name of the field as it will appear in the input
              # @param context [ActionView::Base] the view context
              # @param button [Hash] options for the button
              # @param after_input [String] Text or HTML that goes after the input
              #
              # @option button [String] :classes classes to add to the button
              #
              # @option (see CCS::Components::GovUK::Field::Input::PasswordInput.set_password_input_from_group_options)

              def initialize(attribute:, context:, button: {}, after_input: nil, **options)
                button[:classes] = "govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle #{button[:classes]}".rstrip
                button[:attributes] = {
                  type: :button,
                  aria: {
                    controls: options.dig(:attributes, :id) || field_id(options[:form]&.object_name, attribute),
                    label: options[:show_password_aria_label_text] || 'Show password'
                  },
                  hidden: {
                    value: true,
                    optional: true
                  }
                }

                @show_hide_button = Button.new(text: options[:show_password_text] || 'Show', context: context, classes: button[:classes], attributes: button[:attributes])
                @after_input = after_input
              end

              # Generates the HTML for the GOV.UK Password input show/hide button
              #
              # @return [ActiveSupport::SafeBuffer]

              def render
                capture do
                  concat(show_hide_button.render)
                  concat(after_input) if after_input
                end
              end
            end
          end
        end
      end
    end
  end
end
