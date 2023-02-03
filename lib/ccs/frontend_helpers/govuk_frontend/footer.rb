# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Footer
      #
      # This helper is used for generating the footer component from the
      # {https://design-system.service.gov.uk/components/footer GDS - Components - Footer}

      module Footer
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::FormTagHelper
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for the GOV.UK Footer component
        #
        # @param govuk_footer_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_footer_options [String] :classes additional CSS classes for the footer HTML
        # @option govuk_footer_options [String] :container_class classes that can be added to the inner container
        # @option govuk_footer_options [Array] :navigation (see: {govuk_footer_navigation})
        # @option govuk_footer_options [Hash] :meta (see: {govuk_footer_meta})
        # @option govuk_footer_options [ActiveSupport::SafeBuffer,String] :content_licence The content licence information. See {govuk_footer_content_licence}
        # @option govuk_footer_options [ActiveSupport::SafeBuffer,String] :copyright The copyright information. See {govuk_footer_copyright}
        # @option govuk_footer_options [Hash] :attributes additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Footer
        #                                     which can then be rendered on the page

        def govuk_footer(**govuk_footer_options)
          initialise_attributes_and_set_classes(govuk_footer_options, 'govuk-footer')

          govuk_footer_options[:attributes][:role] = 'contentinfo'

          tag.footer(**govuk_footer_options[:attributes]) do
            tag.div(class: "govuk-width-container #{govuk_footer_options[:container_classes]}".rstrip) do
              if govuk_footer_options[:navigation]
                concat(tag.div(class: 'govuk-footer__navigation') do
                  govuk_footer_options[:navigation].each { |navigation_item| concat(govuk_footer_navigation(navigation_item)) }
                end)
                concat(tag.hr(class: 'govuk-footer__section-break'))
              end
              concat(tag.div(class: 'govuk-footer__meta') do
                concat(tag.div(class: 'govuk-footer__meta-item govuk-footer__meta-item--grow') do
                  concat(govuk_footer_meta(govuk_footer_options[:meta])) if govuk_footer_options[:meta]
                  concat(govuk_footer_logo)
                  concat(govuk_footer_content_licence(govuk_footer_options[:content_licence]))
                end)
                concat(govuk_footer_copyright(govuk_footer_options[:copyright]))
              end)
            end
          end
        end

        private

        # Generates the HTML for the navigation section in {govuk_footer}
        #
        # @param navigation_item [Hash] options that will be used for the navigation section
        #
        # @option navigation_item [String] :title title for a section
        # @option navigation_item [String] :width (default: 'fall') width of each navigation section in the footer
        # @option navigation_item [Integer] :columns amount of columns to display items in navigation section of the footer
        # @option navigation_item [Array] :items array of items to display in the list in navigation section of the footer.
        #                                        Each item can have the following options:
        #                                        - +:text+ list item text
        #                                        - +:href+ list item href
        #                                        - +:attributes+ HTML attributes to add to the link
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the navigation section in {govuk_footer}

        def govuk_footer_navigation(navigation_item)
          tag.div(class: "govuk-footer__section govuk-grid-column-#{navigation_item[:width] || 'full'}") do
            concat(tag.h2(navigation_item[:title], class: 'govuk-footer__heading govuk-heading-m'))
            concat(tag.ul(class: "govuk-footer__list #{"govuk-footer__list--columns-#{navigation_item[:columns]}" if navigation_item[:columns]}".rstrip) do
              navigation_item[:items].each do |item|
                concat(tag.li(class: 'govuk-footer__list-item') do
                  (item[:attributes] ||= {})[:class] = 'govuk-footer__link'

                  link_to(item[:text], item[:href], **item[:attributes])
                end)
              end
            end)
          end
        end

        # Generates the HTML for the meta section in {govuk_footer}
        #
        # @param meta [Hash] options that will be used for the meta section
        #
        # @option meta [String] :visually_hidden_title (default: 'Support links') title for a meta item section
        # @option meta [ActiveSupport::SafeBuffer,String] :text text to add to the meta section of the footer,
        #                                                       which will appear below any links specified using meta.items
        # @option meta [Array] :items array of items to display in the list in meta section of the footer.
        #                                        Each item can have the following options:
        #                                        - +:text+ list item text
        #                                        - +:href+ list item href
        #                                        - +:attributes+ HTML attributes to add to the link
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the meta section in {govuk_footer}

        def govuk_footer_meta(meta)
          concat(tag.h2(meta[:visually_hidden_title] || 'Support links', class: 'govuk-visually-hidden'))
          if meta[:items]
            concat(tag.ul(class: 'govuk-footer__inline-list') do
              meta[:items].each do |meta_item|
                concat(tag.li(class: 'govuk-footer__inline-list-item') do
                  (meta_item[:attributes] ||= {})[:class] = 'govuk-footer__link'

                  link_to(meta_item[:text], meta_item[:href], **meta_item[:attributes])
                end)
              end
            end)
          end
          concat(tag.div(meta[:text], class: 'govuk-footer__meta-custom')) if meta[:text]
        end

        # rubocop:enable Metrics/AbcSize

        # Generates the logo used in {govuk_footer}
        #
        # @return [ActiveSupport::SafeBuffer]

        def govuk_footer_logo
          tag.svg(
            class: 'govuk-footer__licence-logo',
            aria: { hidden: 'true' },
            focusable: 'false',
            xmlns: 'http://www.w3.org/2000/svg',
            viewBox: '0 0 483.2 195.7',
            height: '17',
            width: '41'
          ) do
            tag.path(
              fill: 'currentColor',
              d: 'M421.5 142.8V.1l-50.7 32.3v161.1h112.4v-50.7zm-122.3-9.6A47.12 47.12 0 0 1 221 97.8c0-26 21.1-47.1 47.1-47.1 16.7 0 31.4 8.7 39.7 21.8l42.7-27.2A97.63 97.63 0 0 0 268.1 0c-36.5 0-68.3 20.1-85.1 49.7A98 98 0 0 0 97.8 0C43.9 0 0 43.9 0 97.8s43.9 97.8 97.8 97.8c36.5 0 68.3-20.1 85.1-49.7a97.76 97.76 0 0 0 149.6 25.4l19.4 22.2h3v-87.8h-80l24.3 27.5zM97.8 145c-26 0-47.1-21.1-47.1-47.1s21.1-47.1 47.1-47.1 47.2 21 47.2 47S123.8 145 97.8 145'
            )
          end
        end

        # Generates the content licence used in {govuk_footer}
        #
        # @param content_licence [ActiveSupport::SafeBuffer,String] the content licence information. Defaults to Open Government Licence (OGL) v3 licence
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the content licence used in {govuk_footer}

        def govuk_footer_content_licence(content_licence)
          tag.span(class: 'govuk-footer__licence-description') do
            if content_licence
              concat(content_licence)
            else
              concat('All content is available under the')
              concat(link_to('Open Government Licence v3.0', 'https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/', class: 'govuk-footer__link', rel: 'license'))
              concat(', except where otherwise stated')
            end
          end
        end

        # Generates the copyright used in {govuk_footer}
        #
        # @param copyright [ActiveSupport::SafeBuffer,String] the copyright information, this defaults to Crown Copyright
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the copyright used in {govuk_footer}

        def govuk_footer_copyright(copyright)
          tag.div(class: 'govuk-footer__meta-item') do
            link_to(copyright || '© Crown copyright', 'https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/', class: 'govuk-footer__link govuk-footer__copyright-logo')
          end
        end
      end
    end
  end
end
