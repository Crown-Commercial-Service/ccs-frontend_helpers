require_relative '../item'

module CCS
  module Components
    module GovUK
      class Pagination < Base
        class Item < Base
          # = GOV.UK Pagination Item tag
          #
          # This generates the HTML for the pagination item using a link tag
          #
          # @!attribute [r] href
          #   @return [String] URL for the pagination item

          class Tag < Item
            private

            attr_reader :href

            public

            # @param (see CCS::Components::GovUK::Pagination::Item)
            # @param href [String] the URL for the pagination item
            #
            # @option (see CCS::Components::GovUK::Pagination::Item)

            def initialize(href:, **)
              super(**)

              @href = href
            end

            # Generates the HTML for the GOV.UK Pagination item link
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              super do
                link_to(number, href, **@options[:attributes])
              end
            end
          end
        end
      end
    end
  end
end
