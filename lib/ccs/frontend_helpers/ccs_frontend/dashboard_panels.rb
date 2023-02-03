# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Dashboard Panels
      #
      # This helper is used for generating the dashboard panels component

      module DashboardPanels
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the CCS Dashboard Panels component
        #
        # @param panel_items [Array] the panel items, see {ccs_dashboard_panels_item}
        # @param title_text [String] text for the title of a dashboard panels section
        # @param ccs_dashboard_panels_options [Hash] options that will be used in customising the HTML
        #
        # @option ccs_dashboard_panels_options [String] :classes additional CSS classes for the dashboard panels HTML
        # @option ccs_dashboard_panels_options [String] :width (default: 'full') the width of the dashbaord panel section
        # @option ccs_dashboard_panels_options [Hash] :attributes additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the CCS Dashboard Panels
        #                                     which can then be rendered on the page

        def ccs_dashboard_panels(panel_items, title_text = nil, **ccs_dashboard_panels_options)
          initialise_attributes_and_set_classes(ccs_dashboard_panels_options, 'ccs-dashboard-panels')

          tag.div(**ccs_dashboard_panels_options[:attributes]) do
            tag.div(class: 'govuk-grid-row') do
              tag.div(class: "govuk-grid-column-#{ccs_dashboard_panels_options[:width] || 'full'}") do
                if title_text
                  concat(tag.h2(title_text, class: 'ccs-dashboard-panels__heading govuk-heading-m'))
                  concat(tag.hr(class: 'ccs-dashboard-panels__heading-section-break govuk-section-break govuk-section-break--visible'))
                end
                concat(tag.div(class: 'ccs-dashboard-panels__container') do
                  tag.div(class: 'govuk-grid-row') do
                    panel_items.each { |panel_item| concat(ccs_dashboard_panels_item(panel_item)) }
                  end
                end)
              end
            end
          end
        end

        private

        # Generates the HTML for the a dashboard panel item in {ccs_dashboard_panels}
        #
        # @param panel_item [Hash] options for the dashboard panel item
        #
        # @option panel_item [String] :title the title for the dashboard panel
        # @option panel_item [String] :href the href for the dashboard panel
        # @option panel_item [String] :description the description text for the dashboard panel
        # @option panel_item [String] :width (default: 'one-third') the width of the dashboard panel item
        # @option panel_item [Hash] :attributes additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for a panel item in {ccs_dashboard_panels}

        def ccs_dashboard_panels_item(panel_item)
          (panel_item[:attributes] ||= {})[:class] = "ccs-dashboard-panels__item govuk-grid-column-#{panel_item[:width] || 'one-third'}"

          tag.div(**panel_item[:attributes]) do
            concat(link_to(panel_item[:title], panel_item[:href], class: 'ccs-dashboard-panels__item-title'))
            concat(tag.p(panel_item[:description], class: 'ccs-dashboard-panels__item-description'))
          end
        end
      end
    end
  end
end
