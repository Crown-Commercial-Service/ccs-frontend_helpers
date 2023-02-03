# frozen_string_literal: true

require_relative 'logo'
require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Header
      #
      # This helper is used for generating the header component from the
      # {https://github.com/tim-s-ccs/ts-ccs-frontend/tree/main/src/ccs/components/header CCS - Components - Header}

      module Header
        include SharedMethods
        include Logo
        include ActionView::Helpers::FormTagHelper
        include ActionView::Helpers::UrlHelper

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for the CCS Header component
        #
        # @param ccs_header_options [Hash] options that will be used to generate the header
        #
        # @option ccs_header_options [String] :classes additional CSS classes for the header HTML
        # @option ccs_header_options [Hash] :attributes additional attributes that will added as part of the header HTML
        # @option ccs_header_options [String] :container_classes classes for the container
        # @option ccs_header_options [String] :homepage_url URL of the homepage. Defaults to +https://www.crowncommercial.gov.uk+
        # @option ccs_header_options [Array] :service_authentication see {ccs_service_authentication}
        # @option ccs_header_options [Hash] :service see {ccs_header_service_name}
        # @option ccs_header_options [Hash] :navigation see {ccs_header_navigation}
        # @option ccs_header_options [Hash] :menu_button see {ccs_header_navigation}
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the CCS Header
        #                                     which can then be rendered on the page

        def ccs_header(**ccs_header_options)
          determine_ccs_header_attributes(ccs_header_options)

          tag.header(**ccs_header_options[:attributes]) do
            concat(ccs_service_authentication(ccs_header_options[:service_authentication], ccs_header_options[:container_classes])) if ccs_header_options[:service_authentication]
            concat(tag.div(class: "ccs-header__container #{ccs_header_options[:container_classes]}") do
              concat(ccs_header_logo(**ccs_header_options))
              if ccs_header_options[:service] || ccs_header_options[:navigation]
                concat(tag.div(class: 'ccs-header__content') do
                  concat(ccs_header_service_name(ccs_header_options[:service])) if ccs_header_options[:service]
                  concat(ccs_header_navigation(ccs_header_options[:navigation], ccs_header_options[:menu_button], ccs_header_options[:service])) if ccs_header_options[:navigation]
                end)
              end
            end)
          end
        end

        # rubocop:enable Metrics/AbcSize

        private

        # Generates the service authentication section for {ccs_header}
        #
        # @param service_authentication [Array] array of service authentication items (see {ccs_header_navigation_item})
        # @param container_classes [String] classes for the container
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the service authentication section which is used in {ccs_header}

        def ccs_service_authentication(service_authentication, container_classes)
          tag.div(class: 'ccs-header__service-authentication') do
            tag.div(class: "ccs-header__service-authentication-container #{container_classes}") do
              tag.ul(class: 'ccs-header__service-authentication-list') do
                service_authentication.each do |service_authentication_item|
                  concat(tag.li(class: 'ccs-header__service-authentication-item') do
                    if service_authentication_item[:href]
                      (service_authentication_item[:attributes] ||= {})[:class] = 'ccs-header__link'

                      link_to(service_authentication_item[:text], service_authentication_item[:href], **service_authentication_item[:attributes])
                    else
                      service_authentication_item[:text]
                    end
                  end)
                end
              end
            end
          end
        end

        # Generates the logo for {ccs_header}
        #
        # @param (see ccs_header)
        #
        # @option (see ccs_header)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the logo used in {ccs_header}

        def ccs_header_logo(ccs_header_options)
          tag.div(class: 'ccs-header__logo') do
            link_to(ccs_logo, ccs_header_options[:homepage_url] || 'https://www.crowncommercial.gov.uk', class: 'ccs-header__link ccs-header__link--homepage', aria: { label: 'Crown Commercial Service' })
          end
        end

        # Generates the service name section for {ccs_header}
        #
        # @param service [Hash] options that will be used in the service name section
        #
        # @option service [String] :name the name of the service, included in the header
        # @option service [String] :href URL for the service name anchor
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the service name section which is used in {ccs_header}

        def ccs_header_service_name(service)
          if service[:href]
            link_to(service[:name], service[:href], class: 'ccs-header__link ccs-header__link--service-name')
          else
            tag.span(service[:name], class: 'ccs-header__link--service-name')
          end
        end

        # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity,  Metrics/PerceivedComplexity

        # @option ccs_header_options [String] :navigation_label text for the aria-label attribute of the navigation.
        #                                                       Defaults to the same value as +:text+ in +:menu_button+
        # @option ccs_header_options [String] :navigation_classes classes for the navigation section of the header

        # Generates the navigation section for {ccs_header}
        #
        # @param navigation [Hash] options for the navigation
        # @param menu_button [Hash] options for the menu button
        # @param serivce_name_present [Boolean] flag to indicate if the service name section is present
        #
        # @option navigation [String] :label text for the aria-label attribute of the navigation.
        #                                    Defaults to the same value as +:text+ in +:menu_button+
        # @option navigation [String] :classes classes for the navigation section of the header
        # @option navigation [Array] :primary_items primary navigation items that will be rendered on the page (see {ccs_header_navigation_item})
        # @option navigation [Array] :secondary_items secondary navigation items that will be rendered on the page (see {ccs_header_navigation_item})
        #
        # @option menu_button [String] :text text for the button that opens the mobile navigation menu.
        #                                    By default, this is set to +Menu+.
        # @option menu_button [String] :label text for the aria-label attribute of the button that opens the mobile navigation.
        #                                     Defaults to +Show or hide menu+.
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the navigation section which is used in {ccs_header}

        def ccs_header_navigation(navigation, menu_button, serivce_name_present)
          (menu_button ||= {})[:text] ||= 'Menu'
          navigation_classes = "ccs-header__navigation #{navigation[:classes]}".rstrip
          navigation_classes << ' ccs-header__navigation--no-service-name' unless serivce_name_present

          tag.nav(aria: { label: navigation[:label] || menu_button[:text] }, class: navigation_classes) do
            concat(button_tag(menu_button[:text], type: :button, class: 'ccs-header__menu-button ccs-js-header-toggle', aria: { controls: 'navigation', label: menu_button[:label] || 'Show or hide menu' }, hidden: true))
            concat(tag.div(id: 'navigation', class: 'ccs-header__navigation-lists') do
              if navigation[:secondary_items]
                concat(tag.ul(id: 'navigation-secondary', class: "ccs-header__navigation-secondary-list #{'ccs-header__navigation--no-second-list' unless navigation[:primary_items]}") do
                  navigation[:secondary_items].each { |navigation_item| concat(ccs_header_navigation_item(navigation_item)) }
                end)
              end
              if navigation[:primary_items]
                concat(tag.ul(id: 'navigation-primary', class: "ccs-header__navigation-primary-list #{'ccs-header__navigation--no-second-list' unless navigation[:secondary_items]}") do
                  navigation[:primary_items].each { |navigation_item| concat(ccs_header_navigation_item(navigation_item)) }
                end)
              end
            end)
          end
        end

        # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity,  Metrics/PerceivedComplexity

        # Generates a navigation item for {ccs_header_navigation_item}
        #
        # @param navigation_item [Hash] options that will be used in customising the HTML
        #
        # @option navigation_item [Boolean] :active flag to mark the navigation item as active or not
        # @option navigation_item [String] :text text for the navigation item
        # @option navigation_item [String] :href URL of the navigation item anchor
        # @option navigation_item [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for a navigation item which is used in {ccs_header_navigation_item}

        def ccs_header_navigation_item(navigation_item)
          tag.li(class: "ccs-header__navigation-item #{'ccs-header__navigation-item--active' if navigation_item[:active]}".rstrip) do
            if navigation_item[:href]
              (navigation_item[:attributes] ||= {})[:class] = 'ccs-header__link'

              link_to(navigation_item[:text], navigation_item[:href], **navigation_item[:attributes])
            else
              navigation_item[:text]
            end
          end
        end

        # Sets the default attributes for {ccs_header}
        #
        # @param ccs_header_options [Hash] options that will be used in customising the HTML
        #
        # @option (see ccs_header)

        def determine_ccs_header_attributes(ccs_header_options)
          initialise_attributes_and_set_classes(ccs_header_options, 'ccs-header')
          set_data_module(ccs_header_options, 'ccs-header')

          ccs_header_options[:attributes][:role] = 'banner'
          ccs_header_options[:container_classes] ||= 'govuk-width-container'
        end
      end
    end
  end
end
