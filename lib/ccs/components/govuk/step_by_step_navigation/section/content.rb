require 'action_view'

require_relative 'content/list'
require_relative 'content/paragraph'

module CCS::Components
  module GovUK
    class StepByStepNavigation < Base
      class Section < Base
        # = GOV.UK Step by step navigation section content
        #
        # The content for a navigation section
        #
        # @!attribute [r] section_id
        #   @return [String] ID for the section content
        # @!attribute [r] content_items
        #   @return [Array<Paragraph|List>] An array of the initialised content items

        class Content
          include ActionView::Context
          include ActionView::Helpers

          private

          attr_reader :section_id, :content_items

          public

          # @param content_items [Array<Hash>] array of content items.
          #                                  If the type is +:paragraph+, see {Components::GovUK::StepByStepNavigation::Section::Content::Paragraph#initialize Paragraph#initialize}.
          #                                  If the type is +:list+, see {Components::GovUK::StepByStepNavigation::Section::Content::List#initialize List#initialize}.
          # @param index [String] the index of the section
          # @param id [String] the id of the section

          def initialize(content_items:, index:, id:)
            @section_id = "step-panel-#{id}-#{index}"

            @content_items = content_items.map do |content_item|
              case content_item[:type]
              when :paragraph
                Paragraph.new(text: content_item[:text])
              when :list
                List.new(items: content_item[:items])
              end
            end
          end

          # Generates the HTML for the GOV.UK Step by step navigation section content
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.div(class: 'gem-c-step-nav__panel js-panel', id: section_id) do
              content_items.each { |content_item| concat(content_item.render) }
            end
          end
        end
      end
    end
  end
end
