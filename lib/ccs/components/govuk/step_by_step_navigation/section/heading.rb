require 'action_view'

module CCS
  module Components
    module GovUK
      class StepByStepNavigation < Base
        class Section < Base
          # = GOV.UK Step by step navigation section heading
          #
          # The heading for a navigation section
          #
          # @!attribute [r] text
          #   @return [String] Text for the section heading
          # @!attribute [r] index
          #   @return [String] Index of the section
          # @!attribute [r] logic
          #   @return [String] Optional text to show in the sidebar

          class Heading
            include ActionView::Context
            include ActionView::Helpers

            private

            attr_reader :text, :index, :logic

            public

            # @param text [String] text for the section heading
            # @param index [String] the index of the section
            # @param logic [String] text to show instead of a number in the sidebar

            def initialize(text:, index:, logic: nil)
              @text = text
              @index = index
              @logic = logic
            end

            # rubocop:disable Metrics/AbcSize

            # Generates the HTML for the GOV.UK Step by step navigation section heading
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.div(class: 'gem-c-step-nav__header js-toggle-panel', data: { position: index }) do
                tag.h2(class: 'gem-c-step-nav__title') do
                  concat(tag.span(class: "gem-c-step-nav__circle gem-c-step-nav__circle--#{logic ? 'logic' : 'number'}") do
                    tag.span(class: 'gem-c-step-nav__circle-inner') do
                      tag.span(class: 'gem-c-step-nav__circle-background') do
                        concat(tag.span('Step', class: 'govuk-visually-hidden'))
                        concat(logic || index)
                      end
                    end
                  end)
                  concat(tag.span(class: 'js-step-title') do
                    tag.span(text, class: 'js-step-title-text')
                  end)
                end
              end
            end

            # rubocop:enable Metrics/AbcSize
          end
        end
      end
    end
  end
end
