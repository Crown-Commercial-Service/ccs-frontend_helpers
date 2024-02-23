module CCS
  module Components
    module GovUK
      class Accordion < Base
        class Section
          # = GOV.UK Accordion Section Content
          #
          # The individual accordion section content
          #
          # @!attribute [r] section
          #   @return [Hash] Attributes for the accordion section
          # @!attribute [r] accordion_id
          #   @return [String] ID of the accordion
          # @!attribute [r] index
          #   @return [Integer] Index of the accordion section

          class Content
            include ActionView::Context
            include ActionView::Helpers

            private

            attr_reader :section, :accordion_id, :index

            public

            # @param section [Hash] attributes for the accordion section
            # @param accordion_id [String] ID of the accordion
            # @param index [Integer] the index of the accordion section
            #
            # @option (see CCS::Components::GovUK::Accordion::Section)

            def initialize(section:, accordion_id:, index:)
              @section = section
              @accordion_id = accordion_id
              @index = index
            end

            # Generates the HTML for the GOV.UK Accordion Section Content
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.div(class: 'govuk-accordion__section-content', id: "#{accordion_id}-content-#{index}") do
                section[:content] || tag.p(section[:text], class: 'govuk-body')
              end
            end
          end
        end
      end
    end
  end
end
