require_relative '../../base'

module CCS
  module Components
    module CCS
      class Header < Base
        # = CCS Header link
        #
        # The individual header link item
        #
        # @!attribute [r] text
        #   @return [String] Text for the header link
        # @!attribute [r] li_class
        #   @return [String] The class for the li elements
        # @!attribute [r] href
        #   @return [String] The href for the header link
        # @!attribute [r] method
        #   @return [String] The method for the header request which will make it a button

        class Link < Base
          include ActionView::Helpers::UrlHelper

          private

          attr_reader :text, :li_class, :href, :method

          public

          # @param text [String] the text for the header link
          # @param li_class [String] class for the li elements
          # @param href [String] the href for the header link
          # @param method [String] the method for the header request which will make it a button
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [Boolean] :active flag to mark the navigation item as active or not
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

          def initialize(text:, li_class:, href: nil, method: nil, **)
            super(**)

            @text = text
            @href = href
            @li_class = li_class
            @method = method
          end

          # rubocop:disable Metrics/AbcSize

          # Generates the HTML for the CCS Header link
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.li(class: "#{li_class} #{'ccs-header__navigation-item--active' if options[:active]}".rstrip) do
              if href
                if method
                  options[:attributes][:class] = 'ccs-header__button_as_link'

                  button_to(href, method: method, **options[:attributes]) do
                    text
                  end
                else
                  options[:attributes][:class] = 'ccs-header__link'

                  link_to(text, href, **options[:attributes])
                end
              else
                text
              end
            end
          end

          # rubocop:enable Metrics/AbcSize
        end
      end
    end
  end
end
