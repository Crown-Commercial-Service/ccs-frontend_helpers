require_relative '../../../base'

module CCS
  module Components
    module GovUK
      class Table < Base
        class Header
          # = GOV.UK Table Header head cell
          #
          # The individual table header head cell
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
            # @option options [String] :format specify format of a cell
            # @option options [Hash] :attributes ({}) any additional attributes that will be added as part of the cell

            def initialize(text:, **)
              super(**)

              @options[:attributes][:class] += " govuk-table__header--#{@options[:format]}" if @options[:format]
              @options[:attributes][:scope] = 'col'

              @text = text
            end

            # Generates the HTML for the GOV.UK Table Header head cell
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.th(text, **options[:attributes])
            end

            # The default attributes for the table header head cell

            DEFAULT_ATTRIBUTES = { class: 'govuk-table__header' }.freeze
          end
        end
      end
    end
  end
end
