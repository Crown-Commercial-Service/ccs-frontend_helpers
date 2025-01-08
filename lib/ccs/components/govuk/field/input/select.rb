require_relative '../input'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Input < Field
          # = GOV.UK Select
          #
          # This is used for generating the select component from the
          # {https://design-system.service.gov.uk/components/select GDS - Components - Select}
          #
          # @!attribute [r] items
          #   @return [Array<Hash>] The select items
          # @!attribute [r] selected
          #   @return [String] The selected option

          class Select < Input
            private

            attr_reader :items, :selected

            public

            # @param (see CCS::Components::GovUK::Field::Input#initialize)
            # @param items [Array<Hash>] array of options for select.
            #                            The options are:
            #                            - +:text+ the text of the option item. If this is blank the value is used
            #                            - +:value+ the value of the option item
            #                            - +:attributes+ any additional attributes that will added as part of the option HTML
            # @param selected [String] the selected option
            #
            # @option (see CCS::Components::GovUK::Field::Input#initialize)

            def initialize(attribute:, items:, selected: nil, **)
              super(attribute: attribute, **)

              @items = items.map do |item|
                [
                  item[:text] || item[:value],
                  item[:value].nil? ? item[:text] : item[:value],
                  item[:attributes] || {}
                ]
              end
              @selected = @options[:model] ? @options[:model].send(attribute) : selected
            end

            # Generates the HTML for the GOV.UK Select component
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              super do
                if options[:form]
                  options[:form].select(
                    attribute,
                    items,
                    {},
                    **options[:attributes]
                  )
                else
                  context.select_tag(
                    attribute,
                    context.options_for_select(
                      items,
                      selected
                    ),
                    **options[:attributes]
                  )
                end
              end
            end

            # The default attributes for the select

            DEFAULT_ATTRIBUTES = { class: 'govuk-select' }.freeze
          end
        end
      end
    end
  end
end
