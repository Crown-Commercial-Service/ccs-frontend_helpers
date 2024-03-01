require_relative '../input'
require_relative 'item/divider'
require_relative 'item/checkbox/form'
require_relative 'item/checkbox/tag'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Inputs < Field
          # = GOV.UK Checkboxes
          #
          # This is used for generating the checkboxes component from the
          # {https://design-system.service.gov.uk/components/checkboxes GDS - Components - Checkboxes}
          #
          # @!attribute [r] checkbox_items
          #   @return [Array<Item::Divider|Item::Checkbox|Item::Checkbox>] An array of the initialised checkbox items

          class Checkboxes < Inputs
            private

            attr_reader :checkbox_items

            public

            # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize

            # @param (see CCS::Components::GovUK::Field::Inputs#initialize)
            # @param checkbox_items [Array<Hash>] an array of options for the checkboxes.
            #                                     See {Components::GovUK::Field::Inputs::Item::Checkbox#initialize Checkbox#initialize} for details of the items in the array.
            #
            # @option (see CCS::Components::GovUK::Field::Inputs#initialize)

            def initialize(attribute:, checkbox_items:, **options)
              super(attribute: attribute, **options)

              @options[:values] ||= []
              @options[:values] = (@options[:model] || @options[:form].object).send(attribute) || [] if @options[:model] || @options[:form]

              checkbox_items.each { |checkbox_item| checkbox_item[:checked] = @options[:values].include?(checkbox_item[:value]) } if @options[:values].any?
              checkbox_items.each { |checkbox_item| set_described_by(checkbox_item, @attribute, @error_message, @hint&.send(:options)) } unless @fieldset

              checkbox_item_class = @options[:form] ? Item::Checkbox::Form : Inputs::Item::Checkbox::Tag

              @checkbox_items = checkbox_items.map { |checkbox_item| checkbox_item[:divider] ? Item::Divider.new(divider: checkbox_item[:divider], type: 'checkboxes') : checkbox_item_class.new(attribute: attribute, form: @options[:form], context: @context, **checkbox_item) }
            end

            # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize

            # Generates the HTML for the GOV.UK Checkboxes component
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              super() do
                tag.div(**options[:attributes]) do
                  checkbox_items.each { |checkbox_item| concat(checkbox_item.render) }
                end
              end
            end

            # The default attributes for the checkboxes

            DEFAULT_ATTRIBUTES = { class: 'govuk-checkboxes', data: { module: 'govuk-checkboxes' } }.freeze
          end
        end
      end
    end
  end
end
