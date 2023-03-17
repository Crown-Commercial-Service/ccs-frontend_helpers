require 'action_view'

module CCS::Components
  module GovUK
    class StepByStepNavigation < Base
      class Section < Base
        class Content
          class List
            # = GOV.UK Step by step navigation section content list item
            #
            # Generates the list item HTML for the step by step navigation section content
            #
            # @!attribute [r] text
            #   @return [String] Text for the list item
            # @!attribute [r] classes
            #   @return [String] HTML classes for the list item

            class Item
              include ActionView::Context
              include ActionView::Helpers

              private

              attr_reader :text, :classes

              public

              # @param text [String] the text for the list item
              # @param no_marker [Boolean] flag to hide the bullet marker

              def initialize(text:, no_marker: nil)
                @text = text
                @classes = "gem-c-step-nav__list-item js-list-item #{'gem-c-step-nav__list--no-marker' if no_marker}".rstrip
              end

              # Generates the HTML for an individual the GOV.UK Step by step navigation list item
              #
              # @return [ActiveSupport::SafeBuffer]

              def render
                tag.li(class: classes) do
                  tag.span(text)
                end
              end
            end
          end
        end
      end
    end
  end
end
