require_relative '../input'
require_relative 'date_input/item'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Inputs < Field
          # = GOV.UK Date Input
          #
          # This is used for generating the date input component from the
          # {https://design-system.service.gov.uk/components/date-input GDS - Components -  Date Input}

          class DateInput < Inputs
            # @param (see CCS::Components::GovUK::Field::Inputs#initialize)
            # @param date_items [Array<Hash>] an array of options for the date items.
            #                                 See {Components::GovUK::Field::Inputs::DateInput::Item#initialize Item#initialize} for details of the items in the array.
            #
            # @option (see CCS::Components::GovUK::Field::Inputs#initialize)

            def initialize(attribute:, date_items: nil, **options)
              (options[:fieldset][:attributes] ||= {})[:role] = 'group' if options[:fieldset]

              super(attribute: attribute, **options)

              date_items = default_date_items if date_items.blank?

              @input_items = date_items.map { |date_input_item| Item.new(attribute: attribute, error_message: @error_message, model: @options[:model], form: @options[:form], context: @context, **date_input_item) }
            end

            # The default attributes for the date input

            DEFAULT_ATTRIBUTES = { class: 'govuk-date-input' }.freeze

            private

            # The default date items used if no date items are provided
            #
            # @return [Array<Hash>]

            def default_date_items
              [
                {
                  name: 'day',
                  input: {
                    classes: 'govuk-input--width-2'
                  }
                },
                {
                  name: 'month',
                  input: {
                    classes: 'govuk-input--width-2'
                  }
                },
                {
                  name: 'year',
                  input: {
                    classes: 'govuk-input--width-4'
                  }
                }
              ]
            end
          end
        end
      end
    end
  end
end
