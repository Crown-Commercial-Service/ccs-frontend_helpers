# frozen_string_literal: true

module CCS
  # Components for the GOV.UK Frontend and CCS Frontend using an Object Oriented pattern
  # These are then used in the {CCS::FrontendHelpers FrontendHelpers}
  # to create view helpers that can be used in a Ruby on Rails project

  module Components
    # Component base class that all components will inherit from.
    #
    # It's main purpose is to handle the initialisation of the options
    # which is very similar between components
    #
    # @!attribute [r] options
    #   @return [Hash] Options for the component which defaults to +{ attributes: {} }+
    #                  where +attributes+ are HTML attributes
    # @!attribute [r] context
    #   @return [ActionView::Base] View context where the components are being rendered

    class Base
      private

      attr_accessor :options, :context

      public

      delegate :button_tag, :concat, :label_tag, :link_to, :tag, to: :context

      # @param context [ActionView::Base] the view context where the components are being rendered
      # @param options [Hash] options for the component

      def initialize(context:, **options)
        options[:attributes] ||= {}
        options[:attributes][:class] = "#{default_attributes[:class]} #{options[:classes]}".strip if default_attributes[:class] || options[:classes]
        (options[:attributes][:data] ||= {})[:module] = default_attributes[:data][:module] if default_attributes.dig(:data, :module)

        @context = context
        @options = options
      end

      # The default attributes for the component

      DEFAULT_ATTRIBUTES = {}.freeze

      private

      # The default attributes for the component
      #
      # @return [Hash]

      def default_attributes
        self.class::DEFAULT_ATTRIBUTES
      end

      # Sanitizes string used as HTML tag id
      #
      # @return [String]

      def sanitize_to_id(...)
        @context.send(:sanitize_to_id, ...)
      end
    end
  end
end
