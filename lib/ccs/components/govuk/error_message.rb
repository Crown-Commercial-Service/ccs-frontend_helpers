require_relative '../base'

module CCS
  module Components
    module GovUK
      # = GOV.UK Error Message
      #
      # This is used to generate the error message component from the
      # {https://design-system.service.gov.uk/components/error-message GDS - Components - Error message}
      #
      # @!attribute [r] message
      #   @return [String] Text for the error message
      # @!attribute [r] attribute
      #   @return [String,Symbol] The attribute that has an error
      # @!attribute [r] visually_hidden_text
      #   @return [String] The visually hidden text before the error message

      class ErrorMessage < Base
        private

        attr_reader :message, :attribute, :visually_hidden_text

        public

        # @param message [String] the message to be displayed
        # @param attribute [String, Symbol] the attribute that has an error
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the error message HTML
        # @option options [String] :visually_hidden_text ('Error') visualy hidden text before the error message
        # @option options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML

        def initialize(message:, attribute:, **options)
          super(**options)

          @options[:attributes][:id] ||= "#{attribute}-error" if attribute

          @message = message
          @attribute = attribute
          @visually_hidden_text = @options[:visually_hidden_text] || 'Error'
        end

        # Generates the HTML for the GOV.UK Error message component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.p(**options[:attributes]) do
            if visually_hidden_text.present?
              concat(tag.span("#{visually_hidden_text}:", class: 'govuk-visually-hidden'))
              concat(' ')
            end
            concat(message)
          end
        end

        # The default attributes for the error message

        DEFAULT_ATTRIBUTES = { class: 'govuk-error-message' }.freeze
      end
    end
  end
end
