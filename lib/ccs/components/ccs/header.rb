require_relative '../base'
require_relative 'logo'

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

      class Header < Base
        private

        attr_reader :logo

        public

        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the header HTML
        # @option options [String] :container_classes classes for the container
        # @option options [String] :homepage_url URL of the homepage. Defaults to +/https://www.crowncommercial.gov.uk+
        # @option options [Hash] :attributes additional attributes that will added as part of the header HTML

        def initialize(**)
          super

          @options[:container_classes] ||= 'govuk-width-container'
          @options[:homepage_url] ||= 'https://www.crowncommercial.gov.uk'

          @logo = Logo.new(context: @context)
        end

        # Generates the HTML for the CCS Header component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.header(**options[:attributes]) do
            concat(tag.div(class: "ccs-header__container #{options[:container_classes]}".rstrip) do
              concat(header_logo)
            end)
          end
        end

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
      end
    end
  end
end
