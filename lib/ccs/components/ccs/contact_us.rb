require_relative '../base'

module CCS
  module Components
    module CCS
      # = CCS Contract Us
      #
      # This is used for generating the contact us component from the
      # {https://github.com/Crown-Commercial-Service/ccs-frontend-project/tree/main/packages/ccs-frontend/src/ccs/components/header CCS - Components - Contact Us}
      #
      # @!attribute [r] contact_us_link_href
      #   @return [String] Contact us link href
      # @!attribute [r] contact_us_link_text
      #   @return [String] Contact us link text
      # @!attribute [r] having_problems_text
      #   @return [String] Having problem text
      # @!attribute [r] contact_us_text
      #   @return [String] Contact use text

      class ContactUs < Base
        private

        attr_reader :contact_us_link_href, :contact_us_link_text, :having_problems_text, :contact_us_text

        public

        # @param contact_us_link_href [String] Contact us link href
        # @param contact_us_link_text [String] Contact us link text, defaults to "Contact us (opens in a new tab)"
        # @param having_problems_text [String] Having problem text, defaults to "Having problems with this service?"
        # @param contact_us_text [String] Contact use text, defaults to "for support."
        #
        # @option options [String] :classes additional CSS classes for the contact us HTML
        # @option options [Hash] :attributes additional attributes that will added as part of the contact us HTML

        def initialize(contact_us_link_href:, having_problems_text: nil, contact_us_link_text: nil, contact_us_text: nil, **)
          super(**)

          @contact_us_link_href = contact_us_link_href
          @contact_us_link_text = contact_us_link_text || 'Contact us (opens in a new tab)'
          @having_problems_text = having_problems_text || 'Having problems with this service?'
          @contact_us_text = contact_us_text || 'for support.'
        end

        # Generates the HTML for the CCS Contact Us component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            tag.div(class: 'govuk-width-container') do
              tag.div(class: 'govuk-grid-row') do
                tag.div(class: 'govuk-grid-column-full') do
                  tag.p(class: 'ccs-contact-us-body') do
                    concat(tag.strong(having_problems_text, class: 'ccs-contact-us-body__problems'))
                    concat(link_to(contact_us_link_text, contact_us_link_href, class: 'govuk-link', rel: 'noreferrer noopener', target: '_blank'))
                    concat(contact_us_text)
                  end
                end
              end
            end
          end
        end

        # The default attributes for contact us

        DEFAULT_ATTRIBUTES = { class: 'ccs-contact-us' }.freeze
      end
    end
  end
end
