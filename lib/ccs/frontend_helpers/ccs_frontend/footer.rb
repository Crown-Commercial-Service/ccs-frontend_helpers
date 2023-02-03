# frozen_string_literal: true

require_relative 'logo'
require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Footer
      #
      # This helper is used for generating the footer component from the
      # {https://github.com/tim-s-ccs/ts-ccs-frontend/tree/main/src/ccs/components/footer CCS - Components - Footer}

      module Footer
        include SharedMethods
        include Logo
        include ActionView::Helpers::FormTagHelper
        include ActionView::Helpers::UrlHelper

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for the CCS Footer component
        #
        # @param ccs_footer_options [Hash] options that will be used in customising the HTML
        #
        # @option ccs_footer_options [String] :classes additional CSS classes for the footer HTML
        # @option ccs_footer_options [String] :container_class classes that can be added to the inner container
        # @option ccs_footer_options [Array] :navigation (see: {ccs_footer_navigation})
        # @option ccs_footer_options [Hash] :meta (see: {ccs_footer_meta})
        # @option ccs_footer_options [ActiveSupport::SafeBuffer,String] :copyright The copyright information. See {ccs_footer_copyright}
        # @option ccs_footer_options [Hash] :attributes additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the CCS Footer
        #                                     which can then be rendered on the page

        def ccs_footer(**ccs_footer_options)
          initialise_attributes_and_set_classes(ccs_footer_options, 'ccs-footer')

          ccs_footer_options[:attributes][:role] = 'contentinfo'

          tag.footer(**ccs_footer_options[:attributes]) do
            tag.div(class: "govuk-width-container #{ccs_footer_options[:container_classes]}".rstrip) do
              if ccs_footer_options[:navigation]
                concat(tag.div(class: 'ccs-footer__navigation') do
                  ccs_footer_options[:navigation].each { |navigation_item| concat(ccs_footer_navigation(navigation_item)) }
                end)
                concat(tag.hr(class: 'ccs-footer__section-break'))
              end
              concat(tag.div(class: 'ccs-footer__meta') do
                concat(tag.div(class: 'ccs-footer__meta-item') do
                  concat(tag.div(ccs_logo, class: 'ccs-footer__logo'))
                  concat(ccs_footer_copyright(ccs_footer_options[:copyright]))
                end)
                concat(tag.div(class: 'ccs-footer__meta-item ccs-footer__meta-item--grow') do
                  concat(ccs_footer_meta(ccs_footer_options[:meta])) if ccs_footer_options[:meta]
                end)
              end)
            end
          end
        end

        private

        # Generates the HTML for the navigation section in {ccs_footer}
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
        # @return [ActiveSupport::SafeBuffer] the HTML for the navigation section in {ccs_footer}

        def ccs_footer_navigation(navigation_item)
          tag.div(class: "ccs-footer__section govuk-grid-column-#{navigation_item[:width] || 'full'}") do
            concat(tag.h2(navigation_item[:title], class: 'ccs-footer__heading govuk-heading-m'))
            concat(tag.ul(class: "ccs-footer__list #{"ccs-footer__list--columns-#{navigation_item[:columns]}" if navigation_item[:columns]}".rstrip) do
              navigation_item[:items].each do |item|
                concat(tag.li(class: 'ccs-footer__list-item') do
                  (item[:attributes] ||= {})[:class] = 'ccs-footer__link'

                  link_to(item[:text], item[:href], **item[:attributes])
                end)
              end
            end)
          end
        end

        # Generates the HTML for the meta section in {ccs_footer}
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
        # @return [ActiveSupport::SafeBuffer] the HTML for the meta section in {ccs_footer}

        def ccs_footer_meta(meta)
          concat(tag.h2(meta[:visually_hidden_title] || 'Support links', class: 'govuk-visually-hidden'))
          if meta[:items]
            concat(tag.ul(class: 'ccs-footer__inline-list') do
              meta[:items].each do |meta_item|
                concat(tag.li(class: 'ccs-footer__inline-list-item') do
                  (meta_item[:attributes] ||= {})[:class] = 'ccs-footer__link'

                  link_to(meta_item[:text], meta_item[:href], **meta_item[:attributes])
                end)
              end
            end)
          end
          concat(tag.div(meta[:text], class: 'ccs-footer__meta-custom')) if meta[:text]
        end

        # rubocop:enable Metrics/AbcSize

        # Generates the copyright used in {ccs_footer}
        #
        # @param copyright [ActiveSupport::SafeBuffer,String] the copyright information, this defaults to Crown Copyright
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the copyright used in {ccs_footer}

        def ccs_footer_copyright(copyright)
          tag.div(class: 'ccs-footer__copyright') do
            link_to(copyright || '© Crown copyright', 'https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/', class: 'ccs-footer__link')
          end
        end
      end
    end
  end
end
