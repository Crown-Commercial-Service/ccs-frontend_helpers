require_relative '../../base'
require_relative 'section/heading'
require_relative 'section/content'

module CCS::Components
  module GovUK
    class StepByStepNavigation < Base
      # = GOV.UK Step by step navigation section
      #
      # The individual section for the step by step navigation
      #
      # @!attribute [r] heading
      #   @return [Heading] Initialised heading for the section
      # @!attribute [r] content
      #   @return [Content] Initialised content for the section

      class Section < Base
        private

        attr_reader :heading, :content

        public

        # @param heading [Hash] options for the section heading.
        #                      See {Components::GovUK::StepByStepNavigation::Section::Heading#initialize Heading#initialize} for details of the options.
        # @param content [Hash] options for the section content.
        #                       See {Components::GovUK::StepByStepNavigation::Section::Content#initialize Content#initialize} for details of the options.
        # @param index [String] the index of the section
        # @param context [ActionView::Base] the view context

        def initialize(heading:, content:, index:, context:)
          super(context: context)

          @options[:attributes][:class] = 'gem-c-step-nav__step js-step'
          @options[:attributes][:id] = heading[:text].downcase.gsub(' ', '-').gsub('(', '').gsub(')', '')

          @heading = Heading.new(index: index, **heading)
          @content = Content.new(content_items: content, index: index, id: @options[:attributes][:id])
        end

        # Generates the HTML for the GOV.UK Step by step navigation section
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.li(class: @options[:attributes][:class], id: @options[:attributes][:id]) do
            concat(heading.render)
            concat(content.render)
          end
        end
      end
    end
  end
end
