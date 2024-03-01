require_relative '../base'

module CCS
  module Components
    module GovUK
      # = GOV.UK Button
      #
      # This is used to generate the button component from the
      # {https://design-system.service.gov.uk/components/button GDS - Components - Button}
      #
      # @!attribute [r] text
      #   @return [String] Text for the button
      # @!attribute [r] render_method
      #   @return [String] The method that will be used to render the button

      class Button < Base
        private

        attr_reader :text, :render_method

        public

        # @param text [String] the text that will be shown in the button
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the button HTML
        # @option options [Boolean] :is_start_button indicates if it is a start button
        # @option options [String] :href the URI that will be used in anchor tag
        # @option options [ActionView::Helpers::FormBuilder] :form the form builder used to create the submit button
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(text:, **options)
          super(**options)

          if @options[:attributes][:disabled]
            @options[:attributes][:aria] ||= {}
            @options[:attributes][:aria][:disabled] = true
          end
          @options[:attributes][:class] << ' govuk-button--start' if @options[:is_start_button]

          @text = text
          @render_method = :"render_#{if @options[:href]
                                        :link
                                      elsif @options[:form]
                                        :submit
                                      else
                                        :button
                                      end}"
        end

        # Generates the HTML for the GOV.UK Back link component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          send(@render_method)
        end

        # The default attributes for the button

        DEFAULT_ATTRIBUTES = { class: 'govuk-button', data: { module: 'govuk-button' } }.freeze

        private

        # Generates the HTML for the GOV.UK button component as an anchor tag.
        #
        # @return [ActiveSupport::SafeBuffer]

        def render_link
          @options[:attributes][:role] = :button
          @options[:attributes][:draggable] = false

          link_to(@options[:href], **@options[:attributes]) do
            concat(text)
            concat(start_button_icon) if @options[:is_start_button]
          end
        end

        # Generates the HTML for the GOV.UK button component as a button.
        #
        # @return [ActiveSupport::SafeBuffer]

        def render_button
          button_tag(**@options[:attributes]) do
            concat(text)
            concat(start_button_icon) if @options[:is_start_button]
          end
        end

        # Generates the HTML for the GOV.UK button component as an input.
        #
        # @return [ActiveSupport::SafeBuffer]

        def render_submit
          @options[:form].submit(text, **@options[:attributes])
        end

        # Generates the arrow if the button is a start button
        #
        # @return [ActiveSupport::SafeBuffer]

        def start_button_icon
          tag.svg(class: 'govuk-button__start-icon', xmlns: 'http://www.w3.org/2000/svg', width: 17.5, height: 19, viewBox: '0 0 33 40', aria: { hidden: true }, focusable: false) do
            tag.path(fill: 'currentColor', d: 'M0 0h13l20 20-20 20H0l20-20z')
          end
        end
      end
    end
  end
end
