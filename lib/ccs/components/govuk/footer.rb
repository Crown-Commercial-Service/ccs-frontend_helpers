require_relative '../base'
require_relative 'footer/navigation'
require_relative 'footer/meta'

module CCS::Components
  module GovUK
    # = GOV.UK Footer
    #
    # This is used to generate the footer component from the
    # {https://design-system.service.gov.uk/components/footer GDS - Components - Footer}
    #
    # @!attribute [r] navigation
    #   @return [Array<Navigation>] An array of the initialised navigation sections
    # @!attribute [r] meta
    #   @return [Meta] The initialised meta section

    class Footer < Base
      private

      attr_reader :navigation, :meta

      public

      # @param navigation [Array<Hash>] an array of sections for the footer navigation.
      #                                 See {Components::GovUK::Footer::Navigation#initialize Navigation#initialize} for details of the items in the array.
      # @param meta [Hash] ptions for the meta section of the footer.
      #                    See {Components::GovUK::Footer::Meta#initialize Meta#initialize} for details of the options.
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the footer HTML
      # @option options [String] :container_class classes that can be added to the inner container
      # @option options [ActiveSupport::SafeBuffer,String] :content_licence The content licence information, see {CCS::Components::GovUK::Footer#footer_content_licence footer_content_licence} for default
      # @option options [ActiveSupport::SafeBuffer,String] :copyright The copyright information, (default: '© Crown copyright')
      # @option options [Hash] :attributes additional attributes that will added as part of the HTML

      def initialize(navigation: nil, meta: nil, **options)
        super(**options)

        @options[:attributes][:role] = 'contentinfo'
        @options[:copyright] ||= '© Crown copyright'

        @navigation = navigation&.map { |navigation_item| Navigation.new(context: @context, **navigation_item) }
        @meta = Meta.new(context: @context, **meta) if meta
      end

      # rubocop:disable Metrics/AbcSize

      # Generates the HTML for the GOV.UK Footer component
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.footer(**options[:attributes]) do
          tag.div(class: "govuk-width-container #{options[:container_classes]}".rstrip) do
            if navigation
              concat(tag.div(class: 'govuk-footer__navigation') do
                navigation.each { |navigation_item| concat(navigation_item.render) }
              end)
              concat(tag.hr(class: 'govuk-footer__section-break'))
            end
            concat(tag.div(class: 'govuk-footer__meta') do
              concat(tag.div(class: 'govuk-footer__meta-item govuk-footer__meta-item--grow') do
                concat(meta.render) if meta
                concat(footer_logo)
                concat(footer_content_licence)
              end)
              concat(footer_copyright)
            end)
          end
        end
      end

      # rubocop:enable Metrics/AbcSize

      # The default attributes for the breadcrumbs

      DEFAULT_ATTRIBUTES = { class: 'govuk-footer' }.freeze

      private

      # Generates the logo used in the footer
      #
      # @return [ActiveSupport::SafeBuffer]

      def footer_logo
        tag.svg(
          class: 'govuk-footer__licence-logo',
          aria: { hidden: 'true' },
          focusable: 'false',
          xmlns: 'http://www.w3.org/2000/svg',
          viewBox: '0 0 483.2 195.7',
          height: '17',
          width: '41'
        ) do
          tag.path(
            fill: 'currentColor',
            d: 'M421.5 142.8V.1l-50.7 32.3v161.1h112.4v-50.7zm-122.3-9.6A47.12 47.12 0 0 1 221 97.8c0-26 21.1-47.1 47.1-47.1 16.7 0 31.4 8.7 39.7 21.8l42.7-27.2A97.63 97.63 0 0 0 268.1 0c-36.5 0-68.3 20.1-85.1 49.7A98 98 0 0 0 97.8 0C43.9 0 0 43.9 0 97.8s43.9 97.8 97.8 97.8c36.5 0 68.3-20.1 85.1-49.7a97.76 97.76 0 0 0 149.6 25.4l19.4 22.2h3v-87.8h-80l24.3 27.5zM97.8 145c-26 0-47.1-21.1-47.1-47.1s21.1-47.1 47.1-47.1 47.2 21 47.2 47S123.8 145 97.8 145'
          )
        end
      end

      # Generates the content licence for the footer
      #
      # @return [ActiveSupport::SafeBuffer]

      def footer_content_licence
        tag.span(class: 'govuk-footer__licence-description') do
          if options[:content_licence]
            concat(options[:content_licence])
          else
            concat('All content is available under the')
            concat(link_to('Open Government Licence v3.0', 'https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/', class: 'govuk-footer__link', rel: 'license'))
            concat(', except where otherwise stated')
          end
        end
      end

      # Generates the copyright used in the footer
      #
      # @return [ActiveSupport::SafeBuffer]

      def footer_copyright
        tag.div(class: 'govuk-footer__meta-item') do
          link_to(options[:copyright], 'https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/', class: 'govuk-footer__link govuk-footer__copyright-logo')
        end
      end
    end
  end
end
