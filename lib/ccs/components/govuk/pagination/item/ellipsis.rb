require 'action_view'

module CCS::Components
  module GovUK
    class Pagination < Base
      class Item < Base
        # = GOV.UK Pagination Item ellipsis
        #
        # This generates the HTML for a  pagination ellipsis

        class Ellipsis
          extend ActionView::Context
          extend ActionView::Helpers

          # Generates the HTML for the GOV.UK Pagination Item ellipsis
          #
          # @return [ActiveSupport::SafeBuffer]

          def self.render
            tag.li('⋯', class: 'govuk-pagination__item govuk-pagination__item--ellipses')
          end
        end
      end
    end
  end
end
