require_relative '../../base'

module CCS
  module Components
    module GovUK
      class Pagination < Base
        # = GOV.UK Pagination Item
        #
        # This generates the HTML for the pagination item
        #
        # @!attribute [r] number
        #   @return [String] The number for the item
        # @!attribute [r] li_classes
        #   @return [String] HTML classes for pagination item +li+ element

        class Item < Base
          private

          attr_reader :number, :li_classes

          public

          # @param number [String] the number for the item
          # @param current [Boolean] flag to indicate if this item is the current page
          #
          # @option options [String] :classes additional CSS classes for the item HTML
          # @option options [Symbol] :type the type of item. If the value is +:ellipsis+ then an ellipsis will be rendered
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

          def initialize(number:, current: false, **options)
            super(**options)

            @number = number

            (@options[:attributes][:aria] ||= {})[:label] ||= "Page #{@number}"

            li_classes = 'govuk-pagination__item'

            if current
              li_classes << ' govuk-pagination__item--current'
              @options[:attributes][:aria][:current] = 'page'
            end

            @li_classes = li_classes
          end

          # Generates the HTML for the GOV.UK Pagination item
          #
          # @yield the HTML for the pagination item link/button
          #
          # @return [ActiveSupport::SafeBuffer]

          def render(&block)
            tag.li(class: li_classes, &block)
          end

          # The default attributes for the pagination link

          DEFAULT_ATTRIBUTES = { class: 'govuk-link govuk-pagination__link' }.freeze
        end
      end
    end
  end
end
