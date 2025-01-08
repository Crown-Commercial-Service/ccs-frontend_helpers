require_relative '../../base'

module CCS
  module Components
    module GovUK
      class ErrorSummary < Base
        # = GOV.UK Error Summary Item
        #
        # The individual list item for the error summary
        #
        # @!attribute [r] text
        #   @return [String] Text for the error message item
        # @!attribute [r] href
        #   @return [String] The href for the error message

        class Item < Base
          private

          attr_reader :text, :href

          public

          # @param text [String] the text for the error link item
          # @param href [String] the href for the error link item.
          #                      If provided item will be a link
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML.

          def initialize(text:, href: nil, **)
            super(**)

            @text = text
            @href = href
          end

          # Generates the HTML for the GOV.UK Error Summary Item
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.li do
              if href
                link_to(text, href, **options[:attributes])
              else
                text
              end
            end
          end
        end
      end
    end
  end
end
