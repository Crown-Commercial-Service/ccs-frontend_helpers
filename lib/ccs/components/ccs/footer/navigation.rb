require_relative '../../base'
require_relative 'link'

module CCS::Components
  module CCS
    class Footer < Base
      # = CCS Footer Navigation
      #
      # The individual footer navigation item
      #
      # @!attribute [r] title
      #   @return [String] Title for the navigation section
      # @!attribute [r] navigation_links
      #   @return [Array<Link>] An array of the initialised navigation links
      # @!attribute [r] width
      #   @return [String] Width of the navigation section
      # @!attribute [r] columns
      #   @return [Integer] Number of columns to display the links in

      class Navigation
        include ActionView::Context
        include ActionView::Helpers

        private

        attr_reader :title, :navigation_links, :width, :columns

        public

        # @param title [String] the title for the navigation section
        # @param items [Array<Hash>] an array of links for the navigation section.
        #                            See {Components::CCS::Footer::Link#initialize Link#initialize} for details of the items in the array.
        # @param width [String] ('full') width of each navigation section in the footer
        # @param columns [Integer] (nil) number of columns to display the links
        # @param context [ActionView::Base] the view context

        def initialize(title:, items:, context:, width: nil, columns: nil)
          @title = title
          @navigation_links = items.map { |navigation_link| Link.new(li_class: 'ccs-footer__list-item', context: context, **navigation_link) }
          @width = width || 'full'
          @columns = columns
        end

        # Generates the HTML for the CCS Footer Navigation sections
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(class: "ccs-footer__section govuk-grid-column-#{width}") do
            concat(tag.h2(title, class: 'ccs-footer__heading govuk-heading-m'))
            concat(tag.ul(class: "ccs-footer__list #{"ccs-footer__list--columns-#{columns}" if columns}".rstrip) do
              navigation_links.each { |navigation_link| concat(navigation_link.render) }
            end)
          end
        end
      end
    end
  end
end
