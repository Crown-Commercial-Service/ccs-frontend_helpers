require_relative '../input'
require_relative 'item/divider'
require_relative 'item/radio/form'
require_relative 'item/radio/tag'

module CCS::Components
  module GovUK
    class Field < Base
      class Inputs < Field
        # = GOV.UK Radios
        #
        # This is used for generating the radios component from the
        # {https://design-system.service.gov.uk/components/radios GDS - Components - Radios}
        #
        # @!attribute [r] radio_items
        #   @return [Array<Item::Divider|Item::Radio|Item::Radio>] An array of the initialised radio items

        class Radios < Inputs
          private

          attr_reader :radio_items

          public

          # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

          # @param (see CCS::Components::GovUK::Field::Inputs#initialize)
          # @param radio_items [Array<Hash>] an array of options for the radios.
          #                                  See {Components::GovUK::Field::Inputs::Item::Radio#initialize Radio#initialize} for details of the items in the array.
          #
          # @option (see CCS::Components::GovUK::Field::Inputs#initialize)

          def initialize(attribute:, radio_items:, **options)
            super(attribute: attribute, **options)

            if @options[:model] || @options[:form]
              values = (@options[:model] || @options[:form].object).send(attribute) || []
              radio_items.each { |radio_item| radio_item[:checked] = values.include?(radio_item[:value]) }
            end

            radio_item_class = @options[:form] ? Item::Radio::Form : Inputs::Item::Radio::Tag

            @radio_items = radio_items.map { |radio_item| radio_item[:divider] ? Item::Divider.new(divider: radio_item[:divider], type: 'radios') : radio_item_class.new(attribute: attribute, form: @options[:form], context: @context, **radio_item) }
          end

          # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

          # Generates the HTML for the GOV.UK Radios component
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            super() do
              tag.div(**options[:attributes]) do
                radio_items.each { |radio_item| concat(radio_item.render) }
              end
            end
          end

          # The default attributes for the radios

          DEFAULT_ATTRIBUTES = { class: 'govuk-radios', data: { module: 'govuk-radios' } }.freeze
        end
      end
    end
  end
end
