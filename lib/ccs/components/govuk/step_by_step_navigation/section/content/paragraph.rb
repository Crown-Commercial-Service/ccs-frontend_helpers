require 'action_view'

module CCS
  module Components
    module GovUK
      class StepByStepNavigation < Base
        class Section < Base
          class Content
            # = GOV.UK Step by step navigation section content paragraph
            #
            # Generates the paragraph HTML for the step by step navigation section content
            #
            # @!attribute [r] text
            #   @return [String] Text for the paragraph

            class Paragraph
              include ActionView::Context
              include ActionView::Helpers

              private

              attr_reader :text

              public

              # @param text [String] the text for the paragraph

              def initialize(text:)
                @text = text
              end

              # Generates the HTML for the GOV.UK Step by step navigation section content paragraph
              #
              # @return [ActiveSupport::SafeBuffer]

              def render
                tag.p(text, class: 'gem-c-step-nav__paragraph')
              end
            end
          end
        end
      end
    end
  end
end
