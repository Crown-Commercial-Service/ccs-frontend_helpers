require 'action_view'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Inputs < Field
          class Item < Base
            # = GOV.UK Field Inputs item divider
            #
            # The divider for input items e.g. {CCS::Components::GovUK::Field::Inputs::Checkboxes Checkboxes} or {CCS::Components::GovUK::Field::Inputs::Radios Radios}
            #
            # @!attribute [r] text
            #   @return [String] Text for the divider
            # @!attribute [r] type
            #   @return [String] The type of the item

            class Divider
              include ActionView::Context
              include ActionView::Helpers

              private

              attr_reader :text, :type

              public

              # @param divider [String] the text for the divider
              # @param type [String] the type of the item divider.
              #                      One of +'checkboxes'+ or +'radios'+

              def initialize(divider:, type:)
                @text = divider
                @type = type
              end

              # Generates the HTML for an item divider
              #
              # @return [ActiveSupport::SafeBuffer]

              def render
                tag.div(text, class: "govuk-#{type}__divider")
              end
            end
          end
        end
      end
    end
  end
end
