require_relative '../inputs'
require_relative '../../label'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Inputs < Field
          # = GOV.UK Field Inputs Item
          #
          # This class is used to provided the shared HTML for a
          # {Components::GovUK::Field::Inputs::Item::Checkbox checkbox item} or {Components::GovUK::Field::Inputs::Item::Radio radio item}.
          # It wraps these items with the following:
          # - Item label
          # - Item hint
          # - Item conditional content
          #
          # @!attribute [r] attribute
          #   @return [String,Symbol] The attribute of the item
          # @!attribute [r] value
          #   @return [String] The value of the item
          # @!attribute [r] label
          #   @return [Label] The initialised item label
          # @!attribute [r] hint
          #   @return [Hint] The initialised item hint
          # @!attribute [r] conditional_content
          #   @return [ActiveSupport::SafeBuffer] The conditional HTML

          class Item < Base
            private

            attr_reader :attribute, :value, :label, :hint, :conditional_content

            public

            # @param attribute [String,Symbol] the attribute of the item
            # @param value [String] the value of the item
            # @param hint [Hash] options for an item hint see {CCS::Components::GovUK::Hint#initialize Hint#initialize} for more details.
            #                    If no hint is given then no hint will be rendered
            # @param conditional [Hash] content that will appear if the item is checked.
            #                           If no conditional is given then no conditional content will be rendered
            #
            # @option options [String] :classes additional CSS classes for the item HTML
            # @option options [Boolean] :checked flag to indicate if the item is checked
            # @option options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create item HTML
            # @option options [Hash] :attributes ({}) any additional attributes that will be added as part of the item HTML
            #
            # @option conditional [ActiveSupport::SafeBuffer] content the HTML content
            # @option conditional [Hash] attributes[:id] the id of the conditional section

            def initialize(attribute:, value:, hint: nil, conditional: nil, **options)
              super(**options)

              initialise_item_hint(attribute, value, hint) if hint
              initialize_item_conditional(attribute, value, conditional) if conditional
              @attribute = attribute
              @value = value
            end

            # Generates the HTML to wrap arround a input
            #
            # @yield the item input HTML
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              concat(yield)
              concat(label.render)
              concat(hint.render) if hint
              concat(conditional_content) if conditional_content
            end

            private

            # Initialises the item hint and adds the aira-describedby attribute for the item
            #
            # @param attribute [String, Symbol] the attribute of the item
            # @param value [String] the value of the item
            # @param hint [Hash] the options for the hint

            def initialise_item_hint(attribute, value, hint)
              hint[:attributes] ||= {}
              hint[:classes] = "govuk-#{self.class::ITEM_TYPE}__hint #{hint[:classes]}".rstrip
              hint[:attributes][:id] ||= "#{attribute}_#{value}-item-hint"

              (@options[:attributes][:aria] ||= {})[:describedby] = hint[:attributes][:id]

              @hint = Hint.new(context: @context, **hint)
            end

            # Generate the item conditional HTML and adds the data-aira-controls attribute for the item
            #
            # @param attribute [String, Symbol] the attribute of the item
            # @param value [String] the value of the item
            # @param conditional [Hash] the options for the conditional

            def initialize_item_conditional(attribute, value, conditional)
              conditional[:attributes] ||= {}
              conditional[:attributes][:class] = "govuk-#{self.class::ITEM_TYPE}__conditional #{"govuk-#{self.class::ITEM_TYPE}__conditional--hidden" unless @options[:checked]}".rstrip
              conditional[:attributes][:id] ||= sanitize_to_id("#{attribute}_#{value}_conditional")

              (@options[:attributes][:data] ||= {})[:'aria-controls'] = conditional[:attributes][:id]

              @conditional_content = tag.div(conditional[:content], class: conditional[:attributes][:class], id: conditional[:attributes][:id])
            end
          end
        end
      end
    end
  end
end
