require_relative '../base'
require_relative 'logo'
require_relative 'header/service_authentication'
require_relative 'header/navigation'

module CCS
  module Components
    module CCS
      # = CCS Header
      #
      # This is used for generating the header component from the
      # {https://github.com/Crown-Commercial-Service/ccs-frontend-project/tree/main/packages/ccs-frontend/src/ccs/components/header CCS - Components - Header}
      #
      # @!attribute [r] logo
      #   @return [Logo] The initialised Logo component
      # @!attribute [r] service_authentication
      #   @return [ServiceAuthentication] The initialised service authentication section
      # @!attribute [r] navigation
      #   @return [Navigation] The initialised navigation section
      # @!attribute [r] service
      #   @return [Hash] The options for the service section

      class Header < Base
        private

        attr_reader :logo, :service_authentication, :navigation, :service

        public

        # @param service_authentication_items [Array<Hash>] An array of links for the service authentication section of the header.
        #                                                   See {Components::CCS::Header::ServiceAuthentication#initialize ServiceAuthentication#initialize} for details of the items in the array.
        # @param navigation [Hash] options for the navigation section of the header.
        #                          See {Components::CCS::Header::Navigation#initialize Navigation#initialize} for details of the options.
        # @param menu_button [Hash] options for the menu button in the header.
        #                           See {Components::CCS::Header::Navigation#initialize Navigation#initialize} for details of the options.
        # @param service [Hash] options for the service name
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option service [String] :name the name of the service, included in the header
        # @option service [String] :href URL for the service name anchor
        #
        # @option options [String] :classes additional CSS classes for the header HTML
        # @option options [String] :container_classes classes for the container
        # @option options [String] :homepage_url URL of the homepage. Defaults to +/https://www.crowncommercial.gov.uk+
        # @option options [Hash] :attributes additional attributes that will added as part of the header HTML

        def initialize(service_authentication_items: nil, navigation: nil, menu_button: nil, service: nil, **)
          super(**)

          @options[:container_classes] ||= 'govuk-width-container'
          @options[:homepage_url] ||= 'https://www.crowncommercial.gov.uk'

          @logo = Logo.new(context: @context)
          @service_authentication = ServiceAuthentication.new(service_authentication_items: service_authentication_items, container_classes: @options[:container_classes], context: @context) if service_authentication_items
          @navigation = Navigation.new(navigation: navigation, serivce_name_present: service, menu_button: menu_button, context: @context) if navigation && (navigation[:primary_items] || navigation[:secondary_items])
          @service = service
        end

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for the CCS Header component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.header(**options[:attributes]) do
            concat(service_authentication.render) if service_authentication
            concat(tag.div(class: "ccs-header__container #{options[:container_classes]}".rstrip) do
              concat(header_logo)
              if service || navigation
                concat(tag.div(class: 'ccs-header__content') do
                  concat(header_service_name) if service
                  concat(navigation.render) if navigation
                end)
              end
            end)
          end
        end

        # rubocop:enable Metrics/AbcSize

        # The default attributes for the breadcrumbs

        DEFAULT_ATTRIBUTES = { class: 'ccs-header', data: { module: 'ccs-header' } }.freeze

        private

        # Generates the logo for header
        #
        # @return [ActiveSupport::SafeBuffer]

        def header_logo
          tag.div(class: 'ccs-header__logo') do
            link_to(logo.render, options[:homepage_url], class: 'ccs-header__link ccs-header__link--homepage', aria: { label: 'Crown Commercial Service' })
          end
        end

        # Generates the service name section
        #
        # @return [ActiveSupport::SafeBuffer]

        def header_service_name
          if service[:href]
            link_to(service[:name], service[:href], class: 'ccs-header__link ccs-header__link--service-name')
          else
            tag.span(service[:name], class: 'ccs-header__link--service-name')
          end
        end
      end
    end
  end
end
