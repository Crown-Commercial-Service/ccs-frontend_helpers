require_relative '../checkbox'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Inputs < Field
          class Item < Base
            class Checkbox < Item
              # = GOV.UK Field Inputs Checkbox form tag
              #
              # This is used to generate an individual checkbox item using +form.check_box+

              class Form < Checkbox
                # @param (see CCS::Components::GovUK::Field::Items::Item::Checkbox#initialize)
                #
                # @option (see CCS::Components::GovUK::Field::Items::Item::Checkbox#initialize)

                def initialize(attribute:, label:, **options)
                  super(attribute: attribute, label: label, **options)

                  (label[:attributes] ||= {})[:value] = @value
                  label[:attributes][:for] = @options[:attributes][:id] if @options[:attributes][:id]

                  @options[:attributes][:multiple] = true
                  @options[:attributes][:include_hidden] = false

                  @label = Label.new(attribute: attribute, form: @options[:form], context: @context, **label)
                end

                # Generates the HTML for the checkbox input
                #
                # @return [ActiveSupport::SafeBuffer]

                def render
                  super() do
                    @options[:form].check_box(@attribute, @options[:attributes], @value)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
