require_relative '../../base'

module CCS
  module Components
    module CCS
      class Footer < Base
        # = CCS Footer link
        #
        # The individual footer footer link item
        #
        # @!attribute [r] text
        #   @return [String] Text for the footer link
        # @!attribute [r] href
        #   @return [String] The href for the footer link
        # @!attribute [r] li_class
        #   @return [String] The class for the li elements

        class Link < Base
          private

          attr_reader :text, :href, :li_class

          public

          # @param text [String] the text for the footer link
          # @param href [String] the href for the footer link
          # @param li_class [String] class for the li elements
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

          def initialize(text:, href:, li_class:, **)
            super(**)

            @text = text
            @href = href
            @li_class = li_class
          end

          # Generates the HTML for the CCS Footer link
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.li(class: li_class) do
              options[:attributes][:class] = 'ccs-footer__link'

              link_to(text, href, **options[:attributes])
            end
          end
        end
      end
    end
  end
end
