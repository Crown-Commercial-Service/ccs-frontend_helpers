require_relative '../../../base'

module CCS::Components
  module GovUK
    class Accordion < Base
      class Section
        # = GOV.UK Accordion Section Header
        #
        # The individual accordion section header
        #
        # @!attribute [r] section
        #   @return [Hash] Attributes for the accordion section
        # @!attribute [r] accordion_id
        #   @return [String] ID of the accordion
        # @!attribute [r] index
        #   @return [Integer] Index of the accordion section
        # @!attribute [r] heading_level
        #   @return [Integer] The heading level for the accordion section

        class Header
          include ActionView::Context
          include ActionView::Helpers

          private

          attr_reader :section, :accordion_id, :index, :heading_level

          public

          # @param (see CCS::Components::GovUK::Accordion::Section)
          #
          # @option (see CCS::Components::GovUK::Accordion::Section)

          def initialize(section:, accordion_id:, index:, heading_level:)
            @section = section
            @accordion_id = accordion_id
            @index = index
            @heading_level = heading_level
          end

          # Generates the HTML for the GOV.UK Accordion Section Header
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.div(class: 'govuk-accordion__section-header') do
              concat(tag.send("h#{heading_level}", class: 'govuk-accordion__section-heading') do
                tag.span(section[:heading], class: 'govuk-accordion__section-button', id: "#{accordion_id}-heading-#{index}")
              end)
              concat(tag.div(section[:summary], class: 'govuk-accordion__section-summary govuk-body', id: "#{accordion_id}-summary-#{index}")) if section[:summary]
            end
          end
        end
      end
    end
  end
end
