require_relative '../input'

module CCS::Components
  module GovUK
    class Field < Base
      class Input < Field
        # = GOV.UK Textarea
        #
        # This helper is used for generating the textarea component from the
        # {https://design-system.service.gov.uk/components/textarea GDS - Components - Textarea}
        #
        # @!attribute [r] content
        #   @return [String] The content of the textarea

        class Textarea < Input
          private

          attr_reader :content

          public

          # @param (see CCS::Components::GovUK::Field::Input#initialize)
          # @param content [String] the content of the textarea
          # @param rows [Integer] the number of rows for the text area
          #
          # @option (see CCS::Components::GovUK::Field::Input#initialize)

          def initialize(attribute:, content: nil, rows: 5, **options)
            super(attribute: attribute, **options)

            @options[:attributes][:rows] ||= rows

            @content = @options[:model] ? @options[:model].send(attribute) : content
          end

          # Generates the HTML for the GOV.UK Textarea component
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            super() do
              if options[:form]
                options[:form].text_area(attribute, **options[:attributes])
              else
                context.text_area_tag(attribute, content, **options[:attributes])
              end
            end
          end

          # The default attributes for the textarea

          DEFAULT_ATTRIBUTES = { class: 'govuk-textarea' }.freeze
        end
      end
    end
  end
end
