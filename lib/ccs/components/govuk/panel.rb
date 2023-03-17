require_relative '../base'

module CCS::Components
  module GovUK
    # = GOV.UK Panel
    #
    # This is used to generate the panel component from the
    # {https://design-system.service.gov.uk/components/panel GDS - Components - Panel}
    #
    # @!attribute [r] title_text
    #   @return [String] Text for the panel title
    # @!attribute [r] panel_text
    #   @return [String] Text that will be used for the panel content

    class Panel < Base
      private

      attr_reader :title_text, :panel_text

      public

      # @param title_text [String] title text for the panel which will be contained in haeding tags
      # @param panel_text [String] text to use within the panel component.
      #                            If nil, then a block will be rendered
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the panel HTML
      # @option options [Integer,String] :heading_level (default: 1) heading level for the panel title text
      # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

      def initialize(title_text:, panel_text: nil, **options)
        super(**options)

        @title_text = title_text
        @panel_text = panel_text
      end

      # Generates the HTML for the GOV.UK Panel component
      #
      # @yield HTML that will be contained within the panel body. Ignored if panel text is given
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          concat(tag.send(:"h#{options[:heading_level] || 1}", title_text, class: 'govuk-panel__title'))
          if panel_text || block_given?
            concat(tag.div(class: 'govuk-panel__body') do
              panel_text || yield
            end)
          end
        end
      end

      # The default attributes for the panel

      DEFAULT_ATTRIBUTES = { class: 'govuk-panel govuk-panel--confirmation' }.freeze
    end
  end
end
