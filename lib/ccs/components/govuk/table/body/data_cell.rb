require_relative '../../../base'

module CCS
  module Components
    module GovUK
      class Table < Base
        class Body
          # = GOV.UK Table Body data cell
          #
          # The individual table body data cell
          #
          # @!attribute [r] text
          #   @return [String] Text for the cell

          class DataCell < Base
            private

            attr_reader :text

            public

            # @param text [String]  the text of the cell
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the cell
            # @option options [String] :format specify format of a cell
            # @option options [Hash] :attributes ({}) any additional attributes that will be added as part of the cell

            def initialize(text:, **options)
              super(**options)

              @options[:attributes][:class] += " govuk-table__cell--#{@options[:format]}" if @options[:format]

              @text = text
            end

            # Generates the HTML for the GOV.UK Table Body data cell
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.td(text, **options[:attributes])
            end

            # The default attributes for the table body data cell

            DEFAULT_ATTRIBUTES = { class: 'govuk-table__cell' }.freeze
          end
        end
      end
    end
  end
end
