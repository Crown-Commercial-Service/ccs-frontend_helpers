require_relative '../item'

module CCS::Components
  module GovUK
    class Field < Base
      class Inputs < Field
        class Item < Base
          # = GOV.UK Field Inputs Radio
          #
          # This is used to generate an individual radio item

          class Radio < Item
            # @param (see CCS::Components::GovUK::Field::Items::Item#initialize)
            # label [Hash] attributes for the radio label, see {CCS::Components::GovUK::Label#initialize Label#initialize} for more details.
            #
            # @option (see CCS::Components::GovUK::Field::Items::Item#initialize))

            def initialize(attribute:, label:, **options)
              super(attribute: attribute, **options)

              label[:classes] = "govuk-radios__label #{label[:classes]}".rstrip
            end

            # Generates the HTML to wrap arround a radio input
            #
            # @yield the radio item input HTML
            #
            # @return [ActiveSupport::SafeBuffer]

            def render(&block)
              tag.div(class: 'govuk-radios__item') do
                super(&block)
              end
            end

            # The default attributes for the radio

            DEFAULT_ATTRIBUTES = { class: 'govuk-radios__input' }.freeze

            # The type of the input item

            ITEM_TYPE = 'radios'.freeze
          end
        end
      end
    end
  end
end
