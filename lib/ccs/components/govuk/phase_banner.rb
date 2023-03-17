require_relative '../base'
require_relative 'tag'

module CCS::Components
  module GovUK
    # = GOV.UK Phase banner
    #
    # This is used to generate the phase banner component from the
    # {https://design-system.service.gov.uk/components/phase-banner GDS - Components - Phase banner}
    #
    # @!attribute [r] text
    #   @return [String] Text for the phase banner
    # @!attribute [r] tag_options
    #   @return [Hash] Options for the phase banner tag

    class PhaseBanner < Base
      private

      attr_reader :text, :tag_options

      public

      # @param tag_options [Hash] paramters for the govuk tag (see {Components::GovUK::Tag Tag}).
      #                           options are:
      #                           - +text+
      #                           - +colour+
      #                           - +options+
      # @param text [String] the text for the phase banner.
      #                      If nil, then a block will be rendered
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the phase banner HTML
      # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

      def initialize(tag_options:, text: nil, **options)
        super(**options)

        tag_options[:classes] = "govuk-phase-banner__content__tag #{tag_options[:classes]}".rstrip
        tag_options[:context] = @context

        @text = text
        @tag_options = tag_options
      end

      # Generates the HTML for the GOV.UK Phase banner component
      #
      # @yield HTML that will be used in the phase banner. Ignored if text is passed.
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          tag.p(class: 'govuk-phase-banner__content') do
            concat(Tag.new(**tag_options).render)
            concat(tag.span(class: 'govuk-phase-banner__text') do
              text || yield
            end)
          end
        end
      end

      # The default attributes for the phase banner

      DEFAULT_ATTRIBUTES = { class: 'govuk-phase-banner' }.freeze
    end
  end
end
