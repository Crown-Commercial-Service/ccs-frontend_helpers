require_relative '../item'

module CCS
  module Components
    module GovUK
      class Pagination < Base
        class Item < Base
          # = GOV.UK Pagination Item form
          #
          # This generates the HTML for the pagination item using a button tag
          #
          # @!attribute [r] form
          #   @return [ActionView::Helpers::FormBuilder] Form builder used to create the button

          class Form < Item
            private

            attr_reader :form

            public

            # @param (see CCS::Components::GovUK::Pagination::Item)
            # @param form [ActionView::Helpers::FormBuilder] form builder used to create the button
            #
            # @option (see CCS::Components::GovUK::Pagination::Item)

            def initialize(form:, **options)
              super(**options)

              @options[:attributes][:class] << ' pagination-number--button_as_link'

              @form = form
            end

            # Generates the HTML for the GOV.UK Pagination item button
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              super() do
                form.button(number, **@options[:attributes])
              end
            end
          end
        end
      end
    end
  end
end
