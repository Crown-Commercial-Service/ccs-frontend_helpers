require_relative '../base'
require_relative 'step_by_step_navigation/section'

module CCS
  module Components
    module GovUK
      # = GOV.UK Step by step navigation
      #
      # This is used for generating the Step by step navigation component from the
      # {https://design-system.service.gov.uk/patterns/step-by-step-navigation/ GDS - Pages - Step by step navigation}
      #
      # @!attribute [r] step_by_step_navigation_sections
      #   @return [Array<Section>] An array of the initialised step by step navigation sections

      class StepByStepNavigation < Base
        private

        attr_reader :step_by_step_navigation_sections

        public

        # @param step_by_step_navigation_sections [Array<Hash>] An array of options for the step by step navigation section.
        #                                                       See {Components::GovUK::StepByStepNavigation::Section#initialize Section#initialize} for details of the items in the array.
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the step by step navigation HTML
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(step_by_step_navigation_sections:, **)
          super(**)

          DEFAULT_SHOW_HIDE_TEXT.each { |key, value| @options[:attributes][:data][key] ||= value }

          @step_by_step_navigation_sections = step_by_step_navigation_sections.map.with_index(1) { |step_by_step_section, index| Section.new(index: index.to_s, context: @context, **step_by_step_section) }
        end

        # Generates the HTML for the GOV.UK Step by step navigation component (experimental)
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            tag.ol(class: 'gem-c-step-nav__steps') do
              step_by_step_navigation_sections.each { |step_by_step_navigation_section| concat(step_by_step_navigation_section.render) }
            end
          end
        end

        # The default attributes for the step byt step navigation

        DEFAULT_ATTRIBUTES = { class: 'gem-c-step-nav gem-c-step-nav--large gem-c-step-nav--active', data: { module: 'govuk-step-by-step-navigation' } }.freeze

        # Default text for the show and hide buttons which are part of each section

        DEFAULT_SHOW_HIDE_TEXT = { 'show-text': 'Show', 'hide-text': 'Hide', 'show-all-text': 'Show all', 'hide-all-text': 'Hide all' }.freeze
      end
    end
  end
end
