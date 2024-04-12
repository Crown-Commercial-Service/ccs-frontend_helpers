require_relative '../field'
require_relative '../label'

module CCS
  module Components
    module GovUK
      class Field < Base
        # = GOV.UK Field Input
        #
        # This class is used to create a form for an individual field, e.g. text input or select.
        # It will wrap the input in the form group and:
        # - display the label
        # - display the hint (if there is one)
        # - find and display the error message (if there is one)
        #
        # @!attribute [r] label
        #   @return [Label] The initialised label

        class Input < Field
          private

          attr_reader :label

          public

          # @param (see CCS::Components::GovUK::Field#initialize)
          # @param label [Hash] attributes for the label, see {CCS::Components::GovUK::Label#initialize Label#initialize} for more details.
          # @param before_input [String] text or HTML to go before the input
          # @param after_input [String] text or HTML to go after the input
          #
          # @option (see CCS::Components::GovUK::Field#initialize)

          def initialize(attribute:, label:, **options)
            super(attribute: attribute, **options)

            set_described_by(@options, @attribute, @error_message, options[:hint])

            @options[:attributes][:class] << " #{self.class::DEFAULT_ATTRIBUTES[:class]}--error" if @error_message

            field_id = @options.dig(:attributes, :id)
            (label[:attributes] ||= {})[:for] = field_id if field_id

            @label = Label.new(attribute: attribute, form: @options[:form], context: @context, **label)
          end

          # Generates the HTML to wrap arround a GDS form component
          #
          # @yield (see CCS::Components::GovUK::Field#render)
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            super() do |display_error_message|
              concat(label.render)
              concat(hint.render) if hint
              concat(display_error_message)
              concat(before_input) if before_input
              concat(yield)
              concat(after_input) if after_input
            end
          end
        end
      end
    end
  end
end
