require_relative '../base'

module CCS::Components
  module GovUK
    # = GOV.UK Label
    #
    # This is used to generate the label component from the Government Design Systems
    #
    # @!attribute [r] attribute
    #   @return [String, Symbol] Attribute of the input that requires a label
    # @!attribute [r] text
    #   @return [String] Text for the label
    # @!attribute [r] form
    #   @return [ActionView::Helpers::FormBuilder] Form builder used to create the label

    class Label < Base
      private

      attr_reader :attribute, :text, :form

      public

      # @param attribute [String, Symbol] the attribute of the input that requires a label
      # @param text [String] (nil) the text for the label
      #                            If nil, then a block will be rendered
      # @param form [ActionView::Helpers::FormBuilder] (nil) optional form builder used to create the label
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the label HTML
      # @option options [Boolean] :is_page_heading (false) if the label is also the heading it will rendered in a h1
      # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

      def initialize(attribute:, text: nil, form: nil, **options)
        super(**options)

        @attribute = attribute
        @text = text
        @form = form
      end

      # Generates the HTML for the GOV.UK label component
      #
      # @yield HTML that will be generated for the label
      #
      # @return [ActiveSupport::SafeBuffer]

      def render(&block)
        if options[:is_page_heading]
          tag.h1(class: 'govuk-label-wrapper') do
            label_html(&block)
          end
        else
          label_html(&block)
        end
      end

      # The default attributes for the label

      DEFAULT_ATTRIBUTES = { class: 'govuk-label' }.freeze

      private

      # Generates the HTML for the label.
      # If +:form+ attribute is present, it will be used to generate the label tag
      #
      # @yield HTML that will be used in the label. Ignored if text is passed.
      #
      # @return [ActiveSupport::SafeBuffer]

      def label_html
        if form
          form.label(attribute, **options[:attributes]) do
            text || yield
          end
        else
          label_tag(attribute, **options[:attributes]) do
            text || yield
          end
        end
      end
    end
  end
end
