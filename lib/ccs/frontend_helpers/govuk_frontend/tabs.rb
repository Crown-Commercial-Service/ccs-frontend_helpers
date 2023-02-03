# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Tabs
      #
      # This helper is used for generating the tabs component from the
      # {https://design-system.service.gov.uk/components/tabs GDS - Components - Tabs}

      module Tabs
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::FormTagHelper
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the GOV.UK Tabs component
        #
        # @param items [Array] array of tab items. See {govuk_tabs_list_item}
        # @param title [NilClass,String] title for the tabs table of contents
        # @param govuk_tabs_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_tabs_options [String] :classes additional CSS classes for the tabs HTML
        # @option govuk_tabs_options [String] :id_prefix prefix id for each tab item if no id is specified on each item
        # @option govuk_tabs_options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Tabs
        #                                     which can then be rendered on the page

        def govuk_tabs(items, title = 'Contents', **govuk_tabs_options)
          initialise_attributes_and_set_classes(govuk_tabs_options, 'govuk-tabs')
          set_data_module(govuk_tabs_options, 'govuk-tabs')

          id_prefix = govuk_tabs_options[:id_prefix] || sanitize_to_id(title.downcase)

          tag.div(**govuk_tabs_options[:attributes]) do
            concat(tag.h2(title, class: 'govuk-tabs__title'))
            concat(tag.ul(class: 'govuk-tabs__lis') do
              items.each.with_index(1) { |list_item, index| concat(govuk_tabs_list_item(list_item, index, id_prefix)) }
            end)
            items.each.with_index(1) { |panel_item, index| concat(govuk_tabs_panel_item(panel_item[:panel], index)) }
          end
        end

        private

        # Generates the HTML for a tab list item used in {govuk_tabs}
        #
        # @param list_item [Hash] options used to form the tab
        # @param index [Integer] the index of the tab
        # @param id_prefix [String] prefix id for a tab item if no id is specified
        #
        # @option list_item [String] :label the text label of a tab item
        # @option list_item [Hash] :panel content for panel. See {govuk_tabs_panel_item}
        # @option list_item [Hash] :attributes ({}) any additional attributes that will be added as part of the tab link HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for a tab list item used in {govuk_tabs}

        def govuk_tabs_list_item(list_item, index, id_prefix)
          (list_item[:attributes] ||= {})[:class] = 'govuk-tabs__tab'
          (list_item[:panel][:attributes] ||= {})[:id] ||= "#{id_prefix}-#{index}"

          tag.li(class: "govuk-tabs__list-item #{'govuk-tabs__list-item--selected' if index == 1}".rstrip) do
            link_to(list_item[:label], "##{list_item[:panel][:attributes][:id]}", **list_item[:attributes])
          end
        end

        # Generates the HTML for a tab panel used in {govuk_tabs}
        #
        # @param panel_item [Hash] options used to form the tab panel
        # @param index [Integer] the index of the tab
        #
        # @option panel_item [ActiveSupport::SafeBuffer] :content HTML to use within the each tab panel
        # @option panel_item [String] :text if +:content+ is blank then this is the text within the panel
        # @option panel_item [Hash] :attributes ({}) any additional attributes that will be added as part of the tab panel HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for a tab panel used in {govuk_tabs}

        def govuk_tabs_panel_item(panel_item, index)
          panel_item[:attributes][:class] = "govuk-tabs__panel #{'govuk-tabs__panel--hidden' if index > 1}".rstrip

          tag.div(**panel_item[:attributes]) do
            panel_item[:content] || tag.p(panel_item[:text], class: 'govuk-body')
          end
        end
      end
    end
  end
end
