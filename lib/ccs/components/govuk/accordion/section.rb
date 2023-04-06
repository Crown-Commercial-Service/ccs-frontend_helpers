require_relative 'section/header'
require_relative 'section/content'

module CCS
  module Components
    module GovUK
      class Accordion < Base
        # = GOV.UK Accordion Section
        #
        # The individual accordion section
        #
        # @!attribute [r] header
        #   @return [Header] Initialised accordion section header
        # @!attribute [r] content
        #   @return [Content] Initialised accordion section content
        # @!attribute [r] section_is_expanded
        #   @return [Boolean] flag to indicate of the section should be expanded

        class Section
          include ActionView::Context
          include ActionView::Helpers

          private

          attr_reader :header, :content, :section_is_expanded

          public

          # @param section [Hash] attributes for the accordion section
          # @param accordion_id [String] ID of the accordion
          # @param index [Integer] the index of the accordion section
          # @param heading_level [Integer] heading level, from 1 to 6
          #
          # @option section [Boolean] :expanded sets whether the section should be expanded
          #                                     when the page loads for the first time.
          # @option section [String] :heading the heading text for the accordion
          # @option section [String] :summary (nil) optional summary text for the accordion header
          # @option section [ActiveSupport::SafeBuffer] :content the content within the accordion section
          # @option section [String] : text if +:content+ is +nil+ then the text will be rendered

          def initialize(section:, accordion_id:, index:, heading_level:)
            @section_is_expanded = section[:expanded]
            @header = Header.new(section: section, accordion_id: accordion_id, index: index, heading_level: heading_level)
            @content = Content.new(section: section, accordion_id: accordion_id, index: index)
          end

          # Generates the HTML for the GOV.UK Accordion Section
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.div(class: "govuk-accordion__section #{'govuk-accordion__section--expanded' if section_is_expanded}".rstrip) do
              concat(header.render)
              concat(content.render)
            end
          end
        end
      end
    end
  end
end
