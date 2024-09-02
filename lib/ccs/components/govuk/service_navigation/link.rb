require_relative '../../base'

module CCS
  module Components
    module GovUK
      class ServiceNavigation < Base
        # = GOV.UK Service navigation link
        #
        # The individual service navigation link item
        #
        # @!attribute [r] text
        #   @return [String] Text for the service navigation link
        # @!attribute [r] href
        #   @return [String] The href for the service navigation link

        class Link < Base
          private

          attr_reader :text, :href

          public

          # @param text [String] the text for the service navigation link
          # @param href [String] the href for the service navigation link
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [Boolean] :active flag to mark the navigation item as active or not
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

          def initialize(text:, href: nil, **options)
            super(**options)

            @options[:attributes][:aria] = { current: options[:current] ? 'page' : 'true' } if options[:active] || options[:current]

            @text = text
            @href = href
          end

          # Generates the HTML for the GOV.UK Service navigation link
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.li(class: "govuk-service-navigation__item #{'govuk-service-navigation__item--active' if options[:active] || options[:current]}".rstrip) do
              if href
                options[:attributes][:class] = 'govuk-service-navigation__link'

                link_to(inner_content, href, **options[:attributes])
              else
                options[:attributes][:class] = 'govuk-service-navigation__text'

                tag.span(inner_content, **options[:attributes])
              end
            end
          end

          private

          # Generates the HTML for the inner content of the GOV.UK Service navigation link component
          #
          # @return [ActiveSupport::SafeBuffer]

          def inner_content
            if options[:active] || options[:current]
              tag.strong(text, class: 'govuk-service-navigation__active-fallback')
            else
              text
            end
          end
        end
      end
    end
  end
end
