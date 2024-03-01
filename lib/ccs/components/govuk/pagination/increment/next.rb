require_relative '../increment'

module CCS
  module Components
    module GovUK
      class Pagination < Base
        class Increment < Base
          # = GOV.UK Pagination Next
          #
          # This generates the HTML for the pagination next link

          class Next < Increment
            # @param (see Increment#initialize)
            #
            # @option (see Increment#initialize)

            def initialize(text: nil, **options)
              super(type: :next, text: text, default_text: 'Next', **options)
            end

            # Generates the HTML for the next link in the pagination
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.div(class: 'govuk-pagination__next') do
                super() do
                  concat(pagination_icon) if block_is_level
                  concat(tag.span(class: pagination_text_classes) do
                    concat(text)
                    concat(tag.span(' page', class: 'govuk-visually-hidden')) if text == default_text
                  end)
                  pagination_icon_label_text
                  concat(pagination_icon) unless block_is_level
                end
              end
            end

            # The path for the pagination next icon

            PAGINATION_ICON_PATH = 'm8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z'.freeze
          end
        end
      end
    end
  end
end
