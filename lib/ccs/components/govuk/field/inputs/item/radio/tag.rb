require_relative '../radio'

module CCS::Components
  module GovUK
    class Field < Base
      class Inputs < Field
        class Item < Base
          class Radio < Item
            # = GOV.UK Field Inputs Radio tag
            #
            # This is used to generate an individual radio item using +radio_button_tag+

            class Tag < Radio
              # @param (see CCS::Components::GovUK::Field::Items::Item::Radio#initialize)
              #
              # @option (see CCS::Components::GovUK::Field::Items::Item::Radio#initialize)

              def initialize(attribute:, label:, **options)
                super(attribute: attribute, label: label, **options)

                @options[:attributes][:id] ||= "#{sanitize_to_id(@attribute)}_#{sanitize_to_id(@value)}"

                @label = Label.new(attribute: @options[:attributes][:id], context: @context, **label)
              end

              # Generates the HTML for the radio input
              #
              # @return [ActiveSupport::SafeBuffer]

              def render
                super() do
                  context.radio_button_tag(@attribute, @value, @options[:checked], **@options[:attributes])
                end
              end
            end
          end
        end
      end
    end
  end
end
