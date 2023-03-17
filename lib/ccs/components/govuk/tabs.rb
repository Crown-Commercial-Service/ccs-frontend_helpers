require_relative '../base'
require_relative 'tabs/tab'
require_relative 'tabs/panel'

module CCS::Components
  module GovUK
    # = GOV.UK Tabs
    #
    # This is used to generate the tabs component from the
    # {https://design-system.service.gov.uk/components/tabs GDS - Components - Tabs}
    #
    # @!attribute [r] title
    #   @return [String] Title for the tabs table of contents
    # @!attribute [r] tabs
    #   @return [Array<Tabs::Tab>] an array of initialised tabs
    # @!attribute [r] panels
    #   @return [Array<Tabs::Panel>] an array of initialised panel

    class Tabs < Base
      private

      attr_reader :title, :tabs, :panels

      public

      # @param items [Array<Hash>] array of the tab items.
      #                            See {Components::GovUK::Tabs::Tab#initialize Tab#initialize}
      #                            and {Components::GovUK::Tabs::Panel#initialize Panel#initialize} for details of the items in the array.
      # @param title [NilClass,String] title for the tabs table of contents
      # @param id_prefix [String] prefix id for each tab item if no id is specified on each item
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the tabs HTML
      # @option options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML

      def initialize(items:, title: nil, id_prefix: nil, **options)
        super(**options)

        @title = title || 'Contents'
        id_prefix ||= sanitize_to_id(@title.downcase)
        @tabs = items.map.with_index(1) { |item, index| Tab.new(index: index, id_prefix: id_prefix, context: @context, **item) }
        @panels = items.map.with_index(1) { |item, index| Panel.new(index: index, id_prefix: id_prefix, context: @context, **item[:panel]) }
      end

      # Generates the HTML for the GOV.UK Tabs component
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          concat(tag.h2(title, class: 'govuk-tabs__title'))
          concat(tag.ul(class: 'govuk-tabs__list') do
            @tabs.each { |tab| concat(tab.render) }
          end)
          @panels.each { |panel| concat(panel.render) }
        end
      end

      # The default attributes for the tabs

      DEFAULT_ATTRIBUTES = { class: 'govuk-tabs', data: { module: 'govuk-tabs' } }.freeze
    end
  end
end
