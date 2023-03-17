require_relative '../checkbox'

module CCS::Components
  module GovUK
    class Field < Base
      class Inputs < Field
        class Item < Base
          class Checkbox < Item
            # = GOV.UK Field Inputs Checkbox tag
            #
            # This is used to generate an individual checkbox item using +check_box_tag+

            class Tag < Checkbox
              # @param (see CCS::Components::GovUK::Field::Items::Item::Checkbox#initialize)
              #
              # @option (see CCS::Components::GovUK::Field::Items::Item::Checkbox#initialize)

              def initialize(attribute:, label:, **options)
                super(attribute: attribute, label: label, **options)

                @options[:attributes][:id] ||= "#{sanitize_to_id(@attribute)}_#{sanitize_to_id(@value)}"

                @label = Label.new(attribute: @options[:attributes][:id], context: @context, **label)
              end

              # Generates the HTML for the checkbox input
              #
              # @return [ActiveSupport::SafeBuffer]

              def render
                super() do
                  context.check_box_tag("#{@attribute}[]", @value, @options[:checked], **@options[:attributes])
                end
              end
            end
          end
        end
      end
    end
  end
end
