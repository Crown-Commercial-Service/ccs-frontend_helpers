require_relative '../base'

module CCS
  module Components
    module GovUK
      # = GOV.UK Hint
      #
      # This is used to generate the hint text component from the Government Design Systems
      #
      # @!attribute [r] text
      #   @return [String] Text for the hint

      class Hint < Base
        private

        attr_reader :text

        public

        # @param text [String] the hint text.
        #                      If nil, then a block will be rendered
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the hint HTML
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(text: nil, **options)
          super(**options)

          @text = text
        end

        # Generates the HTML for the GOV.UK Hint component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            text || yield
          end
        end

        # The default attributes for the hint

        DEFAULT_ATTRIBUTES = { class: 'govuk-hint' }.freeze
      end
    end
  end
end
