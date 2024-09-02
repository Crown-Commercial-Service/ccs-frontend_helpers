require_relative 'link'

module CCS
  module Components
    module GovUK
      class ServiceNavigation < Base
        # = GOV.UK Service navigation navigation
        #
        # The service navigation navigation section
        #
        # @!attribute [r] navigation
        #   @return Array<Hash> A hash with navigation options
        # @!attribute [r] navigation_label
        #   @return [String] The aria label for the navigation
        # @!attribute [r] navigation_classes
        #   @return [String] The classes for the navigation
        # @!attribute [r] navigation_id
        #   @return [String] The id for the navigation
        # @!attribute [r] menu_button
        #   @return [Hash] The options for the menu button

        class Navigation
          include ActionView::Context
          include ActionView::Helpers

          private

          attr_reader :navigation, :menu_button

          public

          # rubocop:disable Metrics/CyclomaticComplexity

          # @param navigation [Hash] options for the navigation
          # @param context [ActionView::Base] the view context
          # @param menu_button [Hash] options for the menu button
          #
          # @option navigation [Array] :items an array of links for the navigation section.
          #                            See {Components::GovUK::ServiceNavigation::Link#initialize Link#initialize} for details of the items in the array.
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

            @navigation = { id: navigation[:id] || 'navigation' }

            menu_button[:aria] = { controls: @navigation[:id] }
            menu_button[:aria][:label] = menu_button[:label] if menu_button[:label] && menu_button[:label] != menu_button[:text]

            @menu_button = menu_button
            @navigation[:links] = navigation[:items].map { |navigation_link| Link.new(context: context, **navigation_link) }
            @navigation[:label] = navigation[:label] || menu_button[:text]
            @navigation[:class] = "govuk-service-navigation__wrapper #{navigation[:classes]}".rstrip
          end

          # rubocop:enable Metrics/CyclomaticComplexity

          # Generates the HTML for the GOV.UK Service Navigation navigation
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.nav(aria: { label: navigation[:label] }, class: navigation[:class]) do
              concat(button_tag(menu_button[:text], type: :button, class: 'govuk-service-navigation__toggle govuk-js-service-navigation-toggle', aria: menu_button[:aria], hidden: true))
              concat(tag.ul(id: navigation[:id], class: 'govuk-service-navigation__list') do
                navigation[:links].each { |navigation_link| concat(navigation_link.render) }
              end)
            end
          end
        end
      end
    end
  end
end
