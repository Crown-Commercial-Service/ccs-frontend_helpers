require_relative '../../base'

module CCS::Components
  module CCS
    class DashboardSection < Base
      # = CCS Dashboard Section Panel
      #
      # The individual panel within a dashboard section
      #
      # @!attribute [r] title
      #   @return [String] Text for the panel title
      # @!attribute [r] href
      #   @return [String] The href for the panel
      # @!attribute [r] description
      #   @return [String] Description text for the panel

      class Panel < Base
        private

        attr_reader :title, :href, :description

        public

        # @param title [String] the text for the panel title
        # @param href [String] the href for the panel
        # @param description [String] the description text for the panel
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :width (default: 'one-third') the width of the panel
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML.

        def initialize(title:, href:, description:, **options)
          super(**options)

          @options[:attributes][:class] = "ccs-dashboard-section__panel govuk-grid-column-#{@options[:width] || 'one-third'}"

          @title = title
          @href = href
          @description = description
        end

        # Generates the HTML for the CCS Dashboard Section Panel
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            concat(link_to(title, href, class: 'ccs-dashboard-section__panel-title'))
            concat(tag.p(description, class: 'ccs-dashboard-section__panel-description'))
          end
        end
      end
    end
  end
end
