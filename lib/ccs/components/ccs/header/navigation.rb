require_relative '../../base'
require_relative 'link'

module CCS::Components
  module CCS
    class Header < Base
      # = CCS Header navigation
      #
      # The header navigation section
      #
      # @!attribute [r] primary_links
      #   @return [Array<Link>] An array of the initialised primary navigation links
      # @!attribute [r] secondary_links
      #   @return [Array<Link>] An array of the initialised secondary navigation links
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

        attr_reader :primary_links, :secondary_links, :navigation_label, :navigation_classes, :menu_button

        public

        # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

        # @param navigation [Hash] options for the navigation
        # @param menu_button [Hash] options for the menu button
        # @param context [ActionView::Base] the view context
        #
        # @option navigation [Array] :primary_items an array of primary links for the navigation section.
        #                            See {Components::CCS::Header::Link#initialize Link#initialize} for details of the items in the array.
        # @option navigation [Array] :secondary_items an array of secondary links for the navigation section.
        #                            See {Components::CCS::Header::Link#initialize Link#initialize} for details of the items in the array.
        # @option navigation [String] :classes additional CSS classes for the navigation HTML
        # @option navigation [String] :label text for the aria-label attribute of the navigation. Defaults to the menu button text
        #
        # @option menu_button [String] :text text for the button that opens the mobile navigation menu.
        #                                    By default, this is set to +Menu+.
        # @option menu_button [String] :label text for the aria-label attribute of the button that opens the mobile navigation.
        #                                     Defaults to +Show or hide menu+.

        def initialize(navigation:, serivce_name_present:, context:, menu_button: nil)
          menu_button ||= {}
          menu_button[:text] ||= 'Menu'
          menu_button[:label] ||= 'Show or hide menu'

          @menu_button = menu_button
          @primary_links = navigation[:primary_items]&.map { |navigation_link| Link.new(li_class: LI_CLASS, context: context, **navigation_link) }
          @secondary_links = navigation[:secondary_items]&.map { |navigation_link| Link.new(li_class: LI_CLASS, context: context, **navigation_link) }
          @navigation_label = navigation[:label] || menu_button[:text]
          @navigation_classes = "ccs-header__navigation #{navigation[:classes]}".rstrip
          @navigation_classes << ' ccs-header__navigation--no-service-name' unless serivce_name_present
        end

        # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for the GOV.UK Navigation
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.nav(aria: { label: navigation_label }, class: navigation_classes) do
            concat(button_tag(menu_button[:text], type: :button, class: 'ccs-header__menu-button ccs-js-header-toggle', aria: { controls: 'navigation', label: menu_button[:label] }, hidden: true))
            concat(tag.div(id: 'navigation', class: 'ccs-header__navigation-lists') do
              if secondary_links
                concat(tag.ul(id: 'navigation-secondary', class: "ccs-header__navigation-secondary-list #{'ccs-header__navigation--no-second-list' unless primary_links}".rstrip) do
                  secondary_links.each { |secondary_link| concat(secondary_link.render) }
                end)
              end
              if primary_links
                concat(tag.ul(id: 'navigation-primary', class: "ccs-header__navigation-primary-list #{'ccs-header__navigation--no-second-list' unless secondary_links}".rstrip) do
                  primary_links.each { |primary_link| concat(primary_link.render) }
                end)
              end
            end)
          end
        end

        # rubocop:enable Metrics/AbcSize

        # The li class for the navigation links

        LI_CLASS = 'ccs-header__navigation-item'.freeze
      end
    end
  end
end
