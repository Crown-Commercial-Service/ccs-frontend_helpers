require_relative 'link'

module CCS
  module Components
    module GovUK
      class Header < Base
        # = GOV.UK Header navigation
        #
        # The header navigation section
        #
        # @!attribute [r] navigation_links
        #   @return [Array<Link>] An array of the initialised navigation links
        # @!attribute [r] navigation_label
        #   @return [String] The aria label for the navigation
        # @!attribute [r] navigation_classes
        #   @return [String] The classes for the navigation
        # @!attribute [r] menu_button
        #   @return [Hash] The options for the menu button

        class Navigation
          include ActionView::Context
          include ActionView::Helpers

          private

          attr_reader :navigation_links, :navigation_label, :navigation_classes, :menu_button

          public

          # @param navigation [Hash] options for the navigation
          # @param context [ActionView::Base] the view context
          # @param menu_button [Hash] options for the menu button
          #
          # @option navigation [Array] :items an array of links for the navigation section.
          #                            See {Components::GovUK::Header::Link#initialize Link#initialize} for details of the items in the array.
          # @option navigation [String] :classes additional CSS classes for the navigation HTML
          # @option navigation [String] :label text for the aria-label attribute of the navigation. Defaults to the menu button text
          #
          # @option menu_button [String] :text text for the button that opens the mobile navigation menu.
          #                                    By default, this is set to +Menu+.
          # @option menu_button [String] :label text for the aria-label attribute of the button that opens the mobile navigation.
          #                                     Defaults to +Show or hide menu+.

          def initialize(navigation:, context:, menu_button: nil)
            menu_button ||= {}
            menu_button[:text] ||= 'Menu'
            menu_button[:label] ||= 'Show or hide menu'

            @menu_button = menu_button
            @navigation_links = navigation[:items].map { |navigation_link| Link.new(context: context, **navigation_link) }
            @navigation_label = navigation[:label] || menu_button[:text]
            @navigation_classes = "govuk-header__navigation #{navigation[:classes]}".rstrip
          end

          # Generates the HTML for the GOV.UK Navigation
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.nav(aria: { label: navigation_label }, class: navigation_classes) do
              concat(button_tag(menu_button[:text], type: :button, class: 'govuk-header__menu-button govuk-js-header-toggle', aria: { controls: 'navigation', label: menu_button[:label] }, hidden: true))
              concat(tag.ul(id: 'navigation', class: 'govuk-header__navigation-list') do
                navigation_links.each { |navigation_link| concat(navigation_link.render) }
              end)
            end
          end
        end
      end
    end
  end
end
