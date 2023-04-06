require_relative '../../base'

module CCS
  module Components
    module GovUK
      class Breadcrumbs < Base
        # = GOV.UK Breadcrumbs Link
        #
        # The individual list item for the breadcrumbs
        #
        # @!attribute [r] text
        #   @return [String] Text for the breadcrumb link
        # @!attribute [r] href
        #   @return [String] The href for the breadcrumb link

        class Link < Base
          private

          attr_reader :text, :href

          public

          # @param text [String] the text for the breadcrumb link
          # @param href [String] the href for the breadcrumb link.
          #                      If blank it is assumed that this item relates to current page
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML.
          #                                    If the link is blank then it defaults to +{ aria: { current: 'page' } }+

          def initialize(text:, href: nil, **options)
            super(**options)

            @text = text
            @href = href
          end

          # Generates the HTML for the GOV.UK Breadcrumbs link
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            if href.present?
              options[:attributes][:class] = 'govuk-breadcrumbs__link'

              tag.li(class: 'govuk-breadcrumbs__list-item') do
                link_to(text, href, **options[:attributes])
              end
            else
              tag.li(text, class: 'govuk-breadcrumbs__list-item', aria: { current: 'page' })
            end
          end
        end
      end
    end
  end
end
