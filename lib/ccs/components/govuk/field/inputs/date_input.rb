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
          #
          # @!attribute [r] date_input_items
          #   @return [Array<DateInput::Item>] An array of the initialised date input items

          class DateInput < Inputs
            private

            attr_reader :date_input_items

            public

            # @param (see CCS::Components::GovUK::Field::Inputs#initialize)
            # @param date_items [Array<Hash>] an array of options for the date items.
            #                                 See {Components::GovUK::Field::Inputs::DateInput::Item#initialize Item#initialize} for details of the items in the array.
            #
            # @option (see CCS::Components::GovUK::Field::Inputs#initialize)

            def initialize(attribute:, date_items: default_date_items, **options)
              (options[:fieldset][:attributes] ||= {})[:role] = 'group'

              super(attribute: attribute, **options)

              # date_items ||= default_date_items

              @date_input_items = date_items.map { |date_input_item| Item.new(attribute: attribute, error_message: @error_message, model: @options[:model], form: @options[:form], context: @context, **date_input_item) }
            end

            # Generates the HTML for the GOV.UK date input component
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              super() do
                tag.div(**options[:attributes]) do
                  date_input_items.each { |date_input_item| concat(date_input_item.render) }
                end
              end
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
