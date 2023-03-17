require_relative '../../base'

module CCS::Components
  module GovUK
    class Pagination < Base
      # = GOV.UK Pagination Increment
      #
      # This generates the HTML for a  pagination increment, that is {Previous} and {Next}
      #
      # @!attribute [r] type
      #   @return [Symbol] The type of pagination increment
      # @!attribute [r] text
      #   @return [String] Text for the pagination increment
      # @!attribute [r] block_is_level
      #   @return [Boolean] Flag to indicate if previous and next blocks are level
      # @!attribute [r] label_text
      #   @return [Boolean] Additional label text for when +block_is_level == true+

      class Increment < Base
        private

        attr_reader :type, :text, :block_is_level, :label_text

        public

        # @param type [Symbol] the type of increment, either +:prev+ or +:next+
        # @param text [String] the text for the pagination increment
        # @param block_is_level [Boolean] when there are no items, this will be true and will add extra classes
        #                                 to the link to make the next and previous pagination links level
        # @param label_text [String] additional text for the link when the pagination block is level
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :href the URL for the link
        # @option options  [ActionView::Helpers::FormBuilder] :form optional form builder used to create the button
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

        def initialize(type:, text:, block_is_level:, label_text: nil, **options)
          super(**options)

          @options[:attributes][:class] = "govuk-link govuk-pagination__link #{'pagination--button_as_link' if @options[:form]}".rstrip
          @options[:attributes][:rel] = type.to_s

          @type = type
          @text = text
          @block_is_level = block_is_level
          @label_text = label_text
        end

        # Generates the HTML for the pagination increment link/button
        #
        # @yield the HTML for the increment button/link
        #
        # @return [ActiveSupport::SafeBuffer]

        def render(&block)
          if options[:form]
            options[:form].button(**options[:attributes], &block)
          else
            link_to(options[:href], **options[:attributes], &block)
          end
        end

        private

        # Returns the classes for the link/button label
        #
        # @return [String]

        def pagination_text_classes
          "govuk-pagination__link-title #{'govuk-pagination__link-title--decorated' if block_is_level && !label_text}".rstrip
        end

        # Generates the icon for the pagination increment
        #
        # @return [ActiveSupport::SafeBuffer]

        def pagination_icon
          tag.svg(class: "govuk-pagination__icon govuk-pagination__icon--#{type}", xmlns: 'http://www.w3.org/2000/svg', height: '13', width: '15', aria: { hidden: 'true' }, focusable: 'false', viewBox: '0 0 15 13') do
            tag.path(d: self.class::PAGINATION_ICON_PATH)
          end
        end

        # Generates the label text for when the block is level
        #
        # @return [ActiveSupport::SafeBuffer]

        def pagination_icon_label_text
          return unless block_is_level && label_text

          concat(tag.span(':', class: 'govuk-visually-hidden'))
          concat(tag.span(label_text, class: 'govuk-pagination__link-label'))
        end
      end
    end
  end
end
