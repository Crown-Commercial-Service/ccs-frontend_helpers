require_relative '../date_input'
require_relative '../../input/text_input'

module CCS::Components
  module GovUK
    class Field < Base
      class Inputs < Field
        class DateInput < Inputs
          # = GOV.UK Date Inputs item
          #
          # This is used to generate an individual date input item
          #
          # @!attribute [r] input
          #   @return [TextInput] The initialised text input for the date item

          class Item
            include ActionView::Context
            include ActionView::Helpers

            private

            attr_reader :input

            public

            # rubocop:disable Metrics/ParameterLists

            # @param attribute [String,Symbol] the attribute for the date inputs
            # @param name [String] the name of the date input item
            # @param input [Hash] options for the input of the date input item, see {CCS::Components::GovUK::Field::Input::TextInput#initialize TextInput#initialize} for more details.
            # @param label [Hash] options for the label of the date input item, see {CCS::Components::GovUK::Label#initialize Label#initialize} for more details.
            # @param context [ActionView::Base] the view context
            #
            # @option options [Hash] error_message used as a flag to add the error classes to the item
            # @option options [ActiveModel] :model (nil) optional model used to create the field
            # @option options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create the field

            def initialize(attribute:, name:, context:, input: {}, label: {}, **options)
              input[:classes] = "govuk-date-input__input #{input[:classes]}".rstrip
              input[:classes] << ' govuk-input--error' if options[:error_message]
              (input[:attributes] ||= {})[:inputmode] ||= 'numeric'

              label[:text] ||= name.capitalize
              label[:classes] = 'govuk-date-input__label'

              @input = Input::TextInput.new(attribute: "#{attribute}_#{name}", label: label, model: options[:model], form: options[:form], context: context, **input)
            end

            # rubocop:enable Metrics/ParameterLists

            # Generates the HTML for the date input item
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.div(input.render, class: 'govuk-date-input__item')
            end
          end
        end
      end
    end
  end
end
