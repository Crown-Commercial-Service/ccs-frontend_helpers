require_relative '../base'
require_relative 'accordion/section'

module CCS
  module Components
    module GovUK
      # = GOV.UK Accordion
      #
      # This is used for generating the accordion component from the
      # {https://design-system.service.gov.uk/accordion/back-link GDS - Components - Accordion}
      #
      # @!attribute [r] accordion_sections
      #   @return [Array<Section>] An array of the initialised accordion sections

      class Accordion < Base
        private

        attr_reader :accordion_sections

        public

        # @param accordion_id [String] used as an id in the HTML for the accordion as a whole,
        #                              and also as a prefix for the ids of the section contents
        #                              and the buttons that open them
        # @param accordion_sections [Array<Hash>] an array of accordion section attributes.
        #                                         See {Components::GovUK::Accordion::Section#initialize Section#initialize} for details of the items in the array.
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the accordion HTML
        # @option options [Integer] :heading_level (2) heading level, from 1 to 6
        # @option options [String] :hide_all_sections_text The text content of the ‘Hide all sections’ button at the top of the accordion when all sections are expanded
        # @option options [String] :hide_section_text The text content of the ‘Hide’ button within each section of the accordion, which is visible when the section is expanded
        # @option options [String] :hide_section_aria_label_text  Text made available to assistive technologies, like screen-readers, as the final part of the toggle’s accessible name when the section is expanded. Defaults to "Hide this section".
        # @option options [String] :show_all_sections_text The text content of the ‘Show all sections’ button at the top of the accordion when at least one section is collapsed
        # @option options [String] :show_section_text The text content of the ‘Show’ button within each section of the accordion, which is visible when the section is collapsed
        # @option options [String] :show_section_aria_label_text Text made available to assistive technologies, like screen-readers, as the final part of the toggle’s accessible name when the section is collapsed. Defaults to "Show this section".
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

        def initialize(accordion_id:, accordion_sections:, **options)
          super(**options)

          @options[:attributes][:id] = accordion_id
          @options[:heading_level] ||= 2

          %i[hide_all_sections hide_section hide_section_aria_label show_all_sections show_section show_section_aria_label].each do |data_attribute|
            data_attribute_name = :"#{data_attribute}_text"
            @options[:attributes][:data][:"i18n.#{data_attribute.to_s.gsub('_', '-')}"] = options[data_attribute_name] if options[data_attribute_name]
          end

          @accordion_sections = accordion_sections.map.with_index(1) { |accordion_section, index| Section.new(section: accordion_section, accordion_id: accordion_id, index: index, heading_level: @options[:heading_level]) }
        end

        # Generates the HTML for the GOV.UK Accordion component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            accordion_sections.each { |accordion_section| concat(accordion_section.render) }
          end
        end

        # The default attributes for the accordion

        DEFAULT_ATTRIBUTES = { class: 'govuk-accordion', data: { module: 'govuk-accordion' } }.freeze
      end
    end
  end
end
