# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Header
      #
      # This helper is used for generating the header component from the
      # {https://design-system.service.gov.uk/components/header GDS - Components - Header}

      module Header
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::FormTagHelper
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the GOV.UK Header component
        #
        # @param govuk_header_options [Hash] options that will be used to generate the header
        #
        # @option govuk_header_options [String] :classes additional CSS classes for the header HTML
        # @option govuk_header_options [Hash] :attributes additional attributes that will added as part of the header HTML
        # @option govuk_header_options [String] :container_classes classes for the container
        # @option govuk_header_options [String] :homepage_url URL of the homepage. Defaults to +/+
        # @option govuk_header_options [String] :product_name product name, used when the product name follows on directly from ‘GOV.UK
        # @option govuk_header_options [Hash] :service see {govuk_header_service_name}
        # @option govuk_header_options [Hash] :navigation see {govuk_header_navigation}
        # @option govuk_header_options [Hash] :menu_button see {govuk_header_navigation}
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Header
        #                                     which can then be rendered on the page

        def govuk_header(**govuk_header_options)
          determine_govuk_header_attributes(govuk_header_options)

          tag.header(**govuk_header_options[:attributes]) do
            tag.div(class: "govuk-header__container #{govuk_header_options[:container_classes] || 'govuk-width-container'}") do
              concat(govuk_header_logo(**govuk_header_options))
              if govuk_header_options[:service] || govuk_header_options[:navigation]
                concat(tag.div(class: 'govuk-header__content') do
                  concat(govuk_header_service_name(govuk_header_options[:service])) if govuk_header_options[:service]
                  concat(govuk_header_navigation(govuk_header_options[:navigation], govuk_header_options[:menu_button])) if govuk_header_options[:navigation]
                end)
              end
            end
          end
        end

        private

        # Generates the logo for {govuk_header}
        #
        # @param govuk_header_options [Hash] options that will be used to generate the header
        #
        # @option (see govuk_header)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the logo used in {govuk_header}

        def govuk_header_logo(govuk_header_options)
          tag.div(class: 'govuk-header__logo') do
            link_to(govuk_header_options[:homepage_url] || '/', class: 'govuk-header__link govuk-header__link--homepage') do
              concat(tag.span(class: 'govuk-header__logotype') do
                concat(tag.svg(class: 'govuk-header__logotype-crown', xmlns: 'http://www.w3.org/2000/svg', height: '30', width: '36', aria: { hidden: 'true' }, focusable: 'false', viewBox: '0 0 132 97') do
                  tag.path(fill: 'currentColor', 'fill-rule': 'evenodd', d: 'M25 30.2c3.5 1.5 7.7-.2 9.1-3.7 1.5-3.6-.2-7.8-3.9-9.2-3.6-1.4-7.6.3-9.1 3.9-1.4 3.5.3 7.5 3.9 9zM9 39.5c3.6 1.5 7.8-.2 9.2-3.7 1.5-3.6-.2-7.8-3.9-9.1-3.6-1.5-7.6.2-9.1 3.8-1.4 3.5.3 7.5 3.8 9zM4.4 57.2c3.5 1.5 7.7-.2 9.1-3.8 1.5-3.6-.2-7.7-3.9-9.1-3.5-1.5-7.6.3-9.1 3.8-1.4 3.5.3 7.6 3.9 9.1zm38.3-21.4c3.5 1.5 7.7-.2 9.1-3.8 1.5-3.6-.2-7.7-3.9-9.1-3.6-1.5-7.6.3-9.1 3.8-1.3 3.6.4 7.7 3.9 9.1zm64.4-5.6c-3.6 1.5-7.8-.2-9.1-3.7-1.5-3.6.2-7.8 3.8-9.2 3.6-1.4 7.7.3 9.2 3.9 1.3 3.5-.4 7.5-3.9 9zm15.9 9.3c-3.6 1.5-7.7-.2-9.1-3.7-1.5-3.6.2-7.8 3.7-9.1 3.6-1.5 7.7.2 9.2 3.8 1.5 3.5-.3 7.5-3.8 9zm4.7 17.7c-3.6 1.5-7.8-.2-9.2-3.8-1.5-3.6.2-7.7 3.9-9.1 3.6-1.5 7.7.3 9.2 3.8 1.3 3.5-.4 7.6-3.9 9.1zM89.3 35.8c-3.6 1.5-7.8-.2-9.2-3.8-1.4-3.6.2-7.7 3.9-9.1 3.6-1.5 7.7.3 9.2 3.8 1.4 3.6-.3 7.7-3.9 9.1zM69.7 17.7l8.9 4.7V9.3l-8.9 2.8c-.2-.3-.5-.6-.9-.9L72.4 0H59.6l3.5 11.2c-.3.3-.6.5-.9.9l-8.8-2.8v13.1l8.8-4.7c.3.3.6.7.9.9l-5 15.4v.1c-.2.8-.4 1.6-.4 2.4 0 4.1 3.1 7.5 7 8.1h.2c.3 0 .7.1 1 .1.4 0 .7 0 1-.1h.2c4-.6 7.1-4.1 7.1-8.1 0-.8-.1-1.7-.4-2.4V34l-5.1-15.4c.4-.2.7-.6 1-.9zM66 92.8c16.9 0 32.8 1.1 47.1 3.2 4-16.9 8.9-26.7 14-33.5l-9.6-3.4c1 4.9 1.1 7.2 0 10.2-1.5-1.4-3-4.3-4.2-8.7L108.6 76c2.8-2 5-3.2 7.5-3.3-4.4 9.4-10 11.9-13.6 11.2-4.3-.8-6.3-4.6-5.6-7.9 1-4.7 5.7-5.9 8-.5 4.3-8.7-3-11.4-7.6-8.8 7.1-7.2 7.9-13.5 2.1-21.1-8 6.1-8.1 12.3-4.5 20.8-4.7-5.4-12.1-2.5-9.5 6.2 3.4-5.2 7.9-2 7.2 3.1-.6 4.3-6.4 7.8-13.5 7.2-10.3-.9-10.9-8-11.2-13.8 2.5-.5 7.1 1.8 11 7.3L80.2 60c-4.1 4.4-8 5.3-12.3 5.4 1.4-4.4 8-11.6 8-11.6H55.5s6.4 7.2 7.9 11.6c-4.2-.1-8-1-12.3-5.4l1.4 16.4c3.9-5.5 8.5-7.7 10.9-7.3-.3 5.8-.9 12.8-11.1 13.8-7.2.6-12.9-2.9-13.5-7.2-.7-5 3.8-8.3 7.1-3.1 2.7-8.7-4.6-11.6-9.4-6.2 3.7-8.5 3.6-14.7-4.6-20.8-5.8 7.6-5 13.9 2.2 21.1-4.7-2.6-11.9.1-7.7 8.8 2.3-5.5 7.1-4.2 8.1.5.7 3.3-1.3 7.1-5.7 7.9-3.5.7-9-1.8-13.5-11.2 2.5.1 4.7 1.3 7.5 3.3l-4.7-15.4c-1.2 4.4-2.7 7.2-4.3 8.7-1.1-3-.9-5.3 0-10.2l-9.5 3.4c5 6.9 9.9 16.7 14 33.5 14.8-2.1 30.8-3.2 47.7-3.2z')
                end)
                concat(tag.span('GOV.UK', class: 'govuk-header__logotype-text'))
              end)
              concat(tag.span(govuk_header_options[:product_name], class: 'govuk-header__product-name')) if govuk_header_options[:product_name]
            end
          end
        end

        # Generates the service name section for {govuk_header}
        #
        # @param service [Hash] options that will be used in the service name section
        #
        # @option service [String] :name the name of the service, included in the header
        # @option service [String] :href URL for the service name anchor
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the service name section which is used in {govuk_header}

        def govuk_header_service_name(service)
          if service[:href]
            link_to(service[:name], service[:href], class: 'govuk-header__link govuk-header__service-name')
          else
            tag.span(service[:name], class: 'govuk-header__service-name')
          end
        end

        # Generates the navigation section for {govuk_header}
        #
        # @param navigation [Hash] options for the navigation
        # @param menu_button [Hash] options for the menu button
        #
        # @option navigation [String] :classes additional CSS classes for the navigation HTML
        # @option navigation [String] :label text for the aria-label attribute of the navigation. Defaults to the menu button text
        # @option navigation [Array] :items the navigation items that will be rendered on the page (see {govuk_header_navigation_item})
        #
        # @option menu_button [String] :text text for the button that opens the mobile navigation menu.
        #                                    By default, this is set to +Menu+.
        # @option menu_button [String] :label text for the aria-label attribute of the button that opens the mobile navigation.
        #                                     Defaults to +Show or hide menu+.
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the navigation section which is used in {govuk_header}

        def govuk_header_navigation(navigation, menu_button)
          (menu_button ||= {})[:text] ||= 'Menu'

          tag.nav(aria: { label: navigation[:label] || menu_button[:text] }, class: "govuk-header__navigation #{navigation[:classes]}".rstrip) do
            concat(button_tag(menu_button[:text], type: :button, class: 'govuk-header__menu-button govuk-js-header-toggle', aria: { controls: 'navigation', label: menu_button[:label] || 'Show or hide menu' }, hidden: true))
            concat(tag.ul(id: 'navigation', class: 'govuk-header__navigation-list') do
              navigation[:items].each { |navigation_item| concat(govuk_header_navigation_item(navigation_item)) }
            end)
          end
        end

        # Generates a navigation item for {govuk_header_navigation}
        #
        # @param navigation_item [Hash] options that will be used in customising the HTML
        #
        # @option navigation_item [Boolean] :active flag to mark the navigation item as active or not
        # @option navigation_item [String] :text text for the navigation item
        # @option navigation_item [String] :href URL of the navigation item anchor
        # @option navigation_item [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for a navigation item which is used in {govuk_header_navigation}

        def govuk_header_navigation_item(navigation_item)
          tag.li(class: "govuk-header__navigation-item #{'govuk-header__navigation-item--active' if navigation_item[:active]}".rstrip) do
            if navigation_item[:href]
              (navigation_item[:attributes] ||= {})[:class] = 'govuk-header__link'

              link_to(navigation_item[:text], navigation_item[:href], **navigation_item[:attributes])
            else
              navigation_item[:text]
            end
          end
        end

        # Sets the default attributes for {govuk_header}
        #
        # @param govuk_header_options [Hash] options that will be used in customising the HTML
        #
        # @option (see govuk_header)

        def determine_govuk_header_attributes(govuk_header_options)
          initialise_attributes_and_set_classes(govuk_header_options, 'govuk-header')
          set_data_module(govuk_header_options, 'govuk-header')

          govuk_header_options[:attributes][:role] = 'banner'
        end
      end
    end
  end
end
