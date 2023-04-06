require_relative '../base'
require_relative 'logo'
require_relative 'footer/navigation'
require_relative 'footer/meta'

module CCS
  module Components
    module CCS
      # = CCS Footer
      #
      # This is used for generating the footer component from the
      # {https://github.com/tim-s-ccs/ts-ccs-frontend/tree/main/src/ccs/components/footer CCS - Components - Footer}
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
        #                                 See {Components::CCS::Footer::Navigation#initialize Navigation#initialize} for details of the items in the array.
        # @param meta [Hash] ptions for the meta section of the footer.
        #                    See {Components::CCS::Footer::Meta#initialize Meta#initialize} for details of the options.
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the footer HTML
        # @option options [String] :container_class classes that can be added to the inner container
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

        # Generates the HTML for the CCS Footer component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.footer(**options[:attributes]) do
            tag.div(class: "govuk-width-container #{options[:container_classes]}".rstrip) do
              if navigation
                concat(tag.div(class: 'ccs-footer__navigation') do
                  navigation.each { |navigation_item| concat(navigation_item.render) }
                end)
                concat(tag.hr(class: 'ccs-footer__section-break'))
              end
              concat(tag.div(class: 'ccs-footer__meta') do
                concat(tag.div(class: 'ccs-footer__meta-item') do
                  concat(tag.div(Logo.render, class: 'ccs-footer__logo'))
                  concat(footer_copyright)
                end)
                concat(tag.div(class: 'ccs-footer__meta-item ccs-footer__meta-item--grow') do
                  concat(meta.render) if meta
                end)
              end)
            end
          end
        end

        # rubocop:enable Metrics/AbcSize

        # The default attributes for the breadcrumbs

        DEFAULT_ATTRIBUTES = { class: 'ccs-footer' }.freeze

        private

        # Generates the copyright used in the footer
        #
        # @return [ActiveSupport::SafeBuffer]

        def footer_copyright
          tag.div(class: 'ccs-footer__copyright') do
            link_to(options[:copyright], 'https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/', class: 'ccs-footer__link')
          end
        end
      end
    end
  end
end
