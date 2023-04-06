# frozen_string_literal: true

require_relative '../../components/ccs/dashboard_section'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Dashboard Section
      #
      # This helper is used for generating the dashboard section component

      module DashboardSection
        # Generates the HTML for the CCS Dashboard Section component
        #
        # @param (see CCS::Components::CCS::DashboardSection#initialize)
        #
        # @option (see CCS::Components::CCS::DashboardSection#initialize)
        #
        # @return (see CCS::Components::CCS::DashboardSection#render)

        def ccs_dashboard_section(dashboard_section_panels, title_text = nil, **options)
          Components::CCS::DashboardSection.new(context: self, dashboard_section_panels: dashboard_section_panels, title_text: title_text, **options).render
        end
      end
    end
  end
end
