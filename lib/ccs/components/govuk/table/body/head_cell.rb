require_relative '../../../base'

module CCS::Components
  module GovUK
    class Table < Base
      class Body
        # = GOV.UK Table Body head cell
        #
        # The individual table body head cell
        #
        # @!attribute [r] text
        #   @return [String] Text for the cell

        class HeadCell < Base
          private

          attr_reader :text

          public

          # @param text [String] the text of the cell
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [String] :classes additional CSS classes for the cell
          # @option options [Hash] :attributes ({}) any additional attributes that will be added as part of the cell

          def initialize(text:, **options)
            super(**options)

            @options[:attributes][:scope] = 'row'

            @text = text
          end

          # Generates the HTML for the GOV.UK Table Body head cell
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.th(text, **options[:attributes])
          end

          # The default attributes for the table body head cell

          DEFAULT_ATTRIBUTES = { class: 'govuk-table__header' }.freeze
        end
      end
    end
  end
end
