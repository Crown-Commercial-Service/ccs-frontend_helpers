require_relative '../../base'

module CCS::Components
  module GovUK
    class Tabs < Base
      # = GOV.UK Tabs tab
      #
      # The individual tab
      #
      # @!attribute [r] index
      #   @return [Integer] The index of the tab
      # @!attribute [r] label
      #   @return [String] Text for the tab
      # @!attribute [r] href
      #   @return [String] The href for the tab panel

      class Tab < Base
        private

        attr_reader :index, :label, :href

        public

        # @param index [Integer] the index of the tab
        # @param id_prefix [Integer] prefix used for the id of a panel if no id is specified
        # @param label [String] the text for the tab
        # @param panel [Hash] used to find the id of the panel. See {Components::GovUK::Tabs::Panel#initialize Panel#initialize} for more details
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

        def initialize(index:, id_prefix:, label:, panel:, **options)
          super(**options)

          @options[:attributes][:class] = 'govuk-tabs__tab'

          @index = index
          @label = label
          @href = "##{panel.dig(:attributes, :id) || "#{id_prefix}-#{index}"}"
        end

        # Generates the HTML for the GOV.UK Tabs tab
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.li(class: "govuk-tabs__list-item #{'govuk-tabs__list-item--selected' if index == 1}".rstrip) do
            link_to(label, href, **options[:attributes])
          end
        end
      end
    end
  end
end
