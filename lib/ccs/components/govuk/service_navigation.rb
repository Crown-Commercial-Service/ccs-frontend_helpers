require_relative '../base'
require_relative 'service_navigation/navigation'

module CCS
  module Components
    module GovUK
      # = GOV.UK Service Navigation
      #
      # This is used to generate the service navigation component from the
      # {https://design-system.service.gov.uk/components/service-navigatio GDS - Components - Service navigation}
      #
      # @!attribute [r] text
      #   @return [String] Text for the service navigation
      # @!attribute [r] href
      #   @return [String] The href for the service navigation

      class ServiceNavigation < Base
        private

        attr_reader :navigation, :service

        public

        # @param navigation [Hash] options for the navigation section of the service navigation.
        #                          See {Components::GovUK::ServiceNavigation::Navigation#initialize Navigation#initialize} for details of the options.
        # @param menu_button [Hash] options for the menu button in the service navigation.
        #                           See {Components::GovUK::ServiceNavigation::Navigation#initialize Navigation#initialize} for details of the options.
        # @param service [Hash] options for the service name
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option service [String] :name the name of the service, included in the service navigation
        # @option service [String] :href URL for the service name anchor
        #
        # @option options [String] :classes additional CSS classes for the service navigation HTML
        # @option options [Hash] :attributes additional attributes that will added as part of the service navigation HTML

        def initialize(navigation: nil, menu_button: nil, service: nil, **)
          super(**)

          (@options[:attributes][:aria] ||= {})[:label] ||= 'Service information' if service

          @navigation = Navigation.new(navigation: navigation, menu_button: menu_button, context: @context) if navigation && navigation[:items]&.compact_blank!.present?
          @service = service
        end

        # Generates the HTML for the GOV.UK Service navigation component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          if service
            tag.section(inner_content, **options[:attributes])
          else
            tag.div(inner_content, **options[:attributes])
          end
        end

        # The default attributes for the service navigation

        DEFAULT_ATTRIBUTES = { class: 'govuk-service-navigation', data: { module: 'govuk-service-navigation' } }.freeze

        private

        # Generates the HTML for the inner content of the GOV.UK Service navigation component
        #
        # @return [ActiveSupport::SafeBuffer]

        def inner_content
          tag.div(class: 'govuk-width-container') do
            tag.div(class: 'govuk-service-navigation__container') do
              concat(tag.span(service_navigation_service_name, class: 'govuk-service-navigation__service-name')) if service
              concat(navigation.render) if navigation
            end
          end
        end

        # Generates the service name section
        #
        # @return [ActiveSupport::SafeBuffer]

        def service_navigation_service_name
          if service[:href]
            link_to(service[:name], service[:href], class: 'govuk-service-navigation__link')
          else
            tag.span(service[:name], class: 'govuk-service-navigation__text')
          end
        end
      end
    end
  end
end
