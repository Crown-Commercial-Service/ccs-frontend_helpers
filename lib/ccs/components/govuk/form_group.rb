require_relative '../base'
require_relative 'error_message'

module CCS::Components
  module GovUK
    # = GOV.UK FormGroup
    #
    # This helper is used for generating the form group component from the Government Design Systems
    #
    # @!attribute [r] attribute
    #   @return [String,Symbol] Attribute that the form group is for
    # @!attribute [r] error_message
    #   @return [String] Text for the error message

    class FormGroup < Base
      private

      attr_reader :attribute, :error_message

      public

      # @param attribute [String,Symbol] the attribute that the form group is for
      # @param error_message [String] (nil) the error message to be displayed
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the form group HTML
      # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

      def initialize(attribute:, error_message: nil, **options)
        super(**options)

        @options[:attributes][:id] ||= "#{attribute}-form-group"
        @options[:attributes][:class][..15] = 'govuk-form-group govuk-form-group--error' if error_message

        @attribute = attribute
        @error_message = error_message
      end

      # Generates the HTML for the GOV.UK Form Group component
      #
      # @yield HTML that will be contained within the 'govuk-form-group' div
      #
      # @yieldparam displayed_error_message [ActiveSupport::SafeBuffer] the HTML for the error message (if there is one)
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          yield((ErrorMessage.new(message: error_message, attribute: attribute, context: context).render if error_message))
        end
      end

      # The default attributes for the form group

      DEFAULT_ATTRIBUTES = { class: 'govuk-form-group' }.freeze
    end
  end
end
