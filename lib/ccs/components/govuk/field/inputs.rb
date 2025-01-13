require_relative '../field'
require_relative '../fieldset'

module CCS
  module Components
    module GovUK
      class Field < Base
        # = GOV.UK Field Inputs
        #
        # This class is used to create a form for a list of fields, e.g. radios or checkboxes.
        # It will wrap the inputs in the form group and then the fieldset and:
        # - display the hint (if there is one)
        # - find and display the error message (if there is one)
        #
        # @!attribute [r] fieldset
        #   @return [Fieldset] The initialised fieldset
        # @!attribute [r] input_items
        #   @return [Array<Item>] An array of the initialised items

        class Inputs < Field
          private

          attr_reader :fieldset, :input_items

          public

          # @param (see CCS::Components::GovUK::Field#initialize)
          # @param fieldset [Hash] attributes for the fieldset, see {CCS::Components::GovUK::Fieldset#initialize Fieldset#initialize} for more details.
          #
          # @option (see CCS::Components::GovUK::Field#initialize)

          def initialize(attribute:, fieldset: nil, **options)
            super(attribute: attribute, **options)

            return unless fieldset

            set_described_by(fieldset, @attribute, @error_message, options[:hint])

            @fieldset = Fieldset.new(context: @context, **fieldset)
          end

          # Generates the HTML to wrap arround a GDS form component
          #
          # @yield (see CCS::Components::GovUK::Field#render)
          #
          # @return [ActiveSupport::SafeBuffer]

          def render(&block)
            super do |display_error_message|
              if fieldset
                fieldset.render do
                  field_inner_html(display_error_message, &block)
                end
              else
                field_inner_html(display_error_message, &block)
              end
            end
          end

          private

          # Generates the HTML structure for the field component
          #
          # @yield (see CCS::Components::GovUK::Field#render)
          #
          # @return [ActiveSupport::SafeBuffer]

          def field_inner_html(display_error_message)
            concat(hint.render) if hint
            concat(display_error_message)
            concat(tag.div(**options[:attributes]) do
              concat(before_input) if before_input
              input_items.each { |input_item| concat(input_item.render) }
              concat(after_input) if after_input
            end)
          end
        end
      end
    end
  end
end
