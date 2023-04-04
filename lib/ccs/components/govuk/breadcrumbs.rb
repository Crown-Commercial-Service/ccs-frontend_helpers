require_relative '../base'
require_relative 'breadcrumbs/link'

module CCS::Components
  module GovUK
    # = GOV.UK Breadcrumbs
    #
    # This is used to generate the breadcrumbs component from the
    # {https://design-system.service.gov.uk/components/breadcrumbs GDS - Components - Breadcrumbs}
    #
    # @!attribute [r] breadcrumb_links
    #   @return [Array<Link>] An array of the initialised breadcrumb links

    class Breadcrumbs < Base
      private

      attr_reader :breadcrumb_links

      public

      # @param breadcrumb_links [Array<Hash>] An array of links for the breadcrumbs list.
      #                                       See {Components::GovUK::Breadcrumbs::Link#initialize Link#initialize} for details of the items in the array.
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the breadcrumbs HTML
      # @option options [Boolean] :collapse_on_mobile indicates if it is to colapse breadcrumbs on mobile
      # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

      def initialize(breadcrumb_links:, **options)
        super(**options)
        @options[:attributes][:class] << ' govuk-breadcrumbs--collapse-on-mobile' if @options[:collapse_on_mobile]

        @breadcrumb_links = breadcrumb_links.map { |breadcrumb_link| Link.new(context: @context, **breadcrumb_link) }
      end

      # Generates the HTML for the GOV.UK breadcrumbs component
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          tag.ol(class: 'govuk-breadcrumbs__list') do
            breadcrumb_links.each { |breadcrumb_link| concat(breadcrumb_link.render) }
          end
        end
      end

      # The default attributes for the breadcrumbs

      DEFAULT_ATTRIBUTES = { class: 'govuk-breadcrumbs' }.freeze
    end
  end
end
