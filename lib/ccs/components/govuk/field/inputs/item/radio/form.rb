require_relative '../radio'

module CCS::Components
  module GovUK
    class Field < Base
      class Inputs < Field
        class Item < Base
          class Radio < Item
            # = GOV.UK Field Inputs Radio form tag
            #
            # This is used to generate an individual radio item using +form.check_box+

            class Form < Radio
              # @param (see CCS::Components::GovUK::Field::Items::Item::Radio#initialize)
              #
              # @option (see CCS::Components::GovUK::Field::Items::Item::Radio#initialize)

              def initialize(attribute:, label:, **options)
                super(attribute: attribute, label: label, **options)

                (label[:attributes] ||= {})[:value] = @value
                label[:attributes][:for] = @options[:attributes][:id] if @options[:attributes][:id]

                @label = Label.new(attribute: attribute, form: @options[:form], context: @context, **label)
              end

              # Generates the HTML for the radio input
              #
              # @return [ActiveSupport::SafeBuffer]

              def render
                super() do
                  @options[:form].radio_button(@attribute, @value, **@options[:attributes])
                end
              end
            end
          end
        end
      end
    end
  end
end
