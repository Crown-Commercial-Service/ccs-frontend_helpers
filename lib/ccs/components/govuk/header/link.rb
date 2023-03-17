require_relative '../../base'

module CCS::Components
  module GovUK
    class Header < Base
      # = GOV.UK Header link
      #
      # The individual header link item
      #
      # @!attribute [r] text
      #   @return [String] Text for the header link
      # @!attribute [r] href
      #   @return [String] The href for the header link

      class Link < Base
        private

        attr_reader :text, :href

        public

        # @param text [String] the text for the header link
        # @param href [String] the href for the header link
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [Boolean] :active flag to mark the navigation item as active or not
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

        def initialize(text:, href: nil, **options)
          super(**options)

          @text = text
          @href = href
        end

        # Generates the HTML for the GOV.UK Header link
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.li(class: "govuk-header__navigation-item #{'govuk-header__navigation-item--active' if options[:active]}".rstrip) do
            if href
              options[:attributes][:class] = 'govuk-header__link'

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
