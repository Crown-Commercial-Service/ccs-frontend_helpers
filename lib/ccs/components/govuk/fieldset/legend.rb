require_relative '../../base'

module CCS::Components
  module GovUK
    class Fieldset < Base
      # = GOV.UK Fieldset Legend
      #
      # The legend for the fieldset
      #
      # @!attribute [r] text
      #   @return [String] Text for the fieldset legend
      # @!attribute [r] is_page_heading
      #   @return [Boolean] Flag to indicate of the legend is a the page heading
      # @!attribute [r] caption
      #   @return [Hash] The class for the li elements

      class Legend < Base
        private

        attr_reader :text, :is_page_heading, :caption

        public

        # @param text [String] the text for the fieldset legend
        # @param is_page_heading [Boolean]  if the legend is also the heading it will rendered in a h1
        # @param caption [String] options for the caption to be rendered above the heading if +:is_page_heading+ is true
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the legend HTML
        #
        # @option caption [String] :text text for the caption
        # @option caption [String] :classes additional CSS classes for the caption HTML

        def initialize(text:, is_page_heading: nil, caption: nil, **options)
          super(**options)

          @text = text
          @is_page_heading = is_page_heading
          @caption = caption
        end

        # Generates the HTML for the GOV.UK Fieldset legend
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.legend(class: options[:attributes][:class]) do
            if is_page_heading
              concat(tag.span(caption[:text], class: caption[:classes])) if caption
              concat(tag.h1(text, class: 'govuk-fieldset__heading'))
            else
              text
            end
          end
        end

        # The default attributes for the fieldset legend

        DEFAULT_ATTRIBUTES = { class: 'govuk-fieldset__legend' }.freeze
      end
    end
  end
end
