require_relative '../base'
require_relative 'dashboard_section/panel'

module CCS
  module Components
    module CCS
      # = CCS Dashboard Section
      #
      # This is used for generating the dashboard section component
      #
      # @!attribute [r] dashboard_section_panels
      #   @return [Array<Link>] An array of the initialised dashboard section panels
      # @!attribute [r] title_text
      #   @return [String] Text for the title of a dashboard section

      class DashboardSection < Base
        private

        attr_reader :dashboard_section_panels, :title_text

        public

        # @param dashboard_section_panels [Array<Hash>] An array of options for the dashboard section panels,
        #                                               See {Components::CCS::DashboardSection::Panel#initialize Panel#initialize} for details of the items in the array.
        # @param title_text [String] text for the title of a dashboard section
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the dashboard section HTML
        # @option options [String] :width (default: 'full') the width of the dashboard section
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

        def initialize(dashboard_section_panels:, title_text: nil, **)
          super(**)

          @options[:width] ||= 'full'

          @dashboard_section_panels = dashboard_section_panels.map { |dashboard_section_panel| Panel.new(context: @context, **dashboard_section_panel) }
          @title_text = title_text
        end

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for the CCS dashboard section component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            tag.div(class: 'govuk-grid-row') do
              tag.div(class: "govuk-grid-column-#{options[:width]}") do
                if title_text
                  concat(tag.h2(title_text, class: 'ccs-dashboard-section__heading govuk-heading-m'))
                  concat(tag.hr(class: 'ccs-dashboard-section__heading-section-break govuk-section-break govuk-section-break--visible'))
                end
                concat(tag.div(class: 'govuk-grid-row ccs-dashboard-section__container') do
                  dashboard_section_panels.each { |dashboard_section_panel| concat(dashboard_section_panel.render) }
                end)
              end
            end
          end
        end

        # rubocop:enable Metrics/AbcSize

        # The default attributes for the dashboard section

        DEFAULT_ATTRIBUTES = { class: 'ccs-dashboard-section' }.freeze
      end
    end
  end
end
