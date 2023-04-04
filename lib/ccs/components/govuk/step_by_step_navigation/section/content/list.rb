require 'action_view'

require_relative 'list/item'

module CCS::Components
  module GovUK
    class StepByStepNavigation < Base
      class Section < Base
        class Content
          # = GOV.UK Step by step navigation section content list
          #
          # Generates the list HTML for the step by step navigation section content
          #
          # @!attribute [r] items
          #   @return [Item] Array of initialised list items

          class List
            include ActionView::Context
            include ActionView::Helpers

            private

            attr_reader :items

            public

            # @param items [Array<Hash>] An array of options for the list items
            #                            See {Components::GovUK::StepByStepNavigation::Section::Content::List::Item#initialize Item#initialize} for details of the items in the array.

            def initialize(items:)
              @items = items.map { |item| Item.new(**item) }
            end

            # Generates the HTML for the GOV.UK Step by step navigation section content list
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.ul(class: 'gem-c-step-nav__list gem-c-step-nav__list--choice', data: { length: items.length.to_s }) do
                items.each { |item| concat(item.render) }
              end
            end
          end
        end
      end
    end
  end
end
