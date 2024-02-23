require_relative '../item'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Inputs < Field
          class Item < Base
            # = GOV.UK Field Inputs Checkbox
            #
            # This is used to generate an individual checkbox item

            class Checkbox < Item
              # @param (see CCS::Components::GovUK::Field::Items::Item#initialize)
              # label [Hash] attributes for the checkbox label, see {CCS::Components::GovUK::Label#initialize Label#initialize} for more details.
              #
              # @option (see CCS::Components::GovUK::Field::Items::Item#initialize))

              def initialize(attribute:, label:, **options)
                super(attribute: attribute, item_class: 'govuk-checkboxes__item', **options)

                label[:classes] = "govuk-checkboxes__label #{label[:classes]}".rstrip
              end

              # The default attributes for the checkbox

              DEFAULT_ATTRIBUTES = { class: 'govuk-checkboxes__input' }.freeze

              # The type of the input item

              ITEM_TYPE = 'checkboxes'.freeze
            end
          end
        end
      end
    end
  end
end
