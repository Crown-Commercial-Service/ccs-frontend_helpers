require_relative '../base'
require_relative 'pagination/increment/previous'
require_relative 'pagination/increment/next'
require_relative 'pagination/item/ellipsis'
require_relative 'pagination/item/tag'
require_relative 'pagination/item/form'

module CCS::Components
  module GovUK
    # = GOV.UK Pagination
    #
    # This helper is used for generating the pagination component from the
    # {https://design-system.service.gov.uk/components/pagination GDS - Components - Pagination}
    #
    # @!attribute [r] pagination_previous
    #   @return [Increment::Previous] Initialised pagination previous
    # @!attribute [r] pagination_items
    #   @return [Array<Item::Ellipsis|Item::Tag|Item::Form>] An array of the initialised pagination items
    # @!attribute [r] pagination_next
    #   @return [Increment::Next] Initialised pagination next

    class Pagination < Base
      private

      attr_reader :pagination_previous, :pagination_items, :pagination_next

      public

      # rubocop:disable Metrics/CyclomaticComplexity

      # @param pagination_previous [Hash] attributes for the pagination previous, see {CCS::Components::GovUK::Pagination::Increment::Previous#initialize Previous#initialize} for more details.
      # @param pagination_items [Array<Hash>] An array of options for the pagination items.
      #                                       See {CCS::Components::GovUK::Pagination::Item::Tag#initialize Item::Tag#initialize} and
      #                                       {CCS::Components::GovUK::Pagination::Item::Form#initialize Item::Form#initialize} for details of the items in the array.
      # @param pagination_next [Hash] attributes for the pagination next, see {CCS::Components::GovUK::Pagination::Increment::Next#initialize Next#initialize} for more details.
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the pagination HTML
      # @option options [ActionView::Helpers::FormBuilder] :form form builder used to create pagination buttons
      # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

      def initialize(pagination_previous: nil, pagination_items: nil, pagination_next: nil, **options)
        super(**options)

        block_is_level = pagination_items.blank? && (pagination_previous.present? || pagination_next.present?)

        @options[:attributes][:class] << ' govuk-pagination--block' if block_is_level
        @options[:attributes][:role] = 'navigation'
        (@options[:attributes][:aria] ||= {})[:label] ||= 'results'

        @pagination_previous = Increment::Previous.new(block_is_level: block_is_level, form: @options[:form], context: @context, **pagination_previous) if pagination_previous
        @pagination_next = Increment::Next.new(block_is_level: block_is_level, form: @options[:form], context: @context, **pagination_next) if pagination_next
        initialize_pagination_items(pagination_items, @options[:form])
      end

      # rubocop:enable Metrics/CyclomaticComplexity

      # Generates the HTML for the GOV.UK pagination component
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.nav(**options[:attributes]) do
          concat(pagination_previous.render) if pagination_previous
          if pagination_items
            concat(tag.ul(class: 'govuk-pagination__list') do
              pagination_items.each { |pagination_item| concat(pagination_item.render) }
            end)
          end
          concat(pagination_next.render) if pagination_next
        end
      end

      # The default attributes for the pagination

      DEFAULT_ATTRIBUTES = { class: 'govuk-pagination' }.freeze

      private

      # Initialises the pagination items
      #
      # @param pagination_items [Array<Hash>] An array of options for the pagination items
      # @param form [ActionView::Helpers::FormBuilder] form builder used to create pagination buttons

      def initialize_pagination_items(pagination_items, form)
        return unless pagination_items

        pagination_item_class = form ? Item::Form : Item::Tag

        @pagination_items = pagination_items.map { |pagination_item| pagination_item[:type] == :ellipsis ? Item::Ellipsis : pagination_item_class.new(form: form, context: context, **pagination_item) }
      end
    end
  end
end
