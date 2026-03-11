require_relative '../base'
require_relative 'logo'

module CCS
  module Components
    module GovUK
      # = GOV.UK Header
      #
      # This is used to generate the header component from the
      # {https://design-system.service.gov.uk/components/header GDS - Components - Header}
      #
      # @!attribute [r] navigation
      #   @return [Navigation] The initialised navigation section
      # @!attribute [r] service
      #   @return [Hash] The options for the service section
      # @!attribute [r] logo
      #   @return [Logo] The initialised logo component

      class Header < Base
        private

        attr_reader :navigation, :service, :logo

        public

        # @param navigation [Hash] options for the navigation section of the header.
        #                          See {Components::GovUK::Header::Navigation#initialize Navigation#initialize} for details of the options.
        # @param menu_button [Hash] options for the menu button in the header.
        #                           See {Components::GovUK::Header::Navigation#initialize Navigation#initialize} for details of the options.
        # @param service [Hash] options for the service name
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option service [String] :name the name of the service, included in the header
        # @option service [String] :href URL for the service name anchor
        #
        # @option options [String] :classes additional CSS classes for the header HTML
        # @option options [String] :container_classes classes for the container
        # @option options [String] :homepage_url URL of the homepage. Defaults to +/+
        # @option options [String] :product_name product name, used when the product name follows on directly from ‘GOV.UK
        # @option options [Hash] :attributes additional attributes that will added as part of the header HTML

        def initialize(**)
          super

          @options[:container_classes] ||= 'govuk-width-container'
          @options[:homepage_url] ||= '//gov.uk'

          @logo = Logo.new(classes: 'govuk-header__logotype', attributes: { aria: { label: 'GOV.UK' } }, context: @context)
        end

        # Generates the HTML for the GOV.UK Header component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            tag.div(class: "govuk-header__container #{options[:container_classes]}") do
              concat(header_logo)
            end
          end
        end

        # The default attributes for the breadcrumbs

        DEFAULT_ATTRIBUTES = { class: 'govuk-header' }.freeze

        private

        # Generates the logo for header
        #
        # @return [ActiveSupport::SafeBuffer]

        def header_logo
          tag.div(class: 'govuk-header__logo') do
            link_to(options[:homepage_url], class: 'govuk-header__homepage-link') do
              concat(logo.render)
              concat(tag.span(options[:product_name], class: 'govuk-header__product-name')) if options[:product_name]
            end
          end
        end
      end
    end
  end
end
