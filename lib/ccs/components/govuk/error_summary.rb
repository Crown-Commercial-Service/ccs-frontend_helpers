require_relative '../base'
require_relative 'error_summary/item'

module CCS
  module Components
    module GovUK
      # = GOV.UK Error Summary
      #
      # This is used to generate the error summary component from the
      # {https://design-system.service.gov.uk/components/error-summary GDS - Components - Error summary}
      #
      # @!attribute [r] title
      #   @return [String] Heading for the error summary
      # @!attribute [r] error_summary_items
      #   @return [Array<Item>] An array of the initialised error summary items
      # @!attribute [r] description
      #   @return [String] Text to use for the description of the errors

      class ErrorSummary < Base
        private

        attr_reader :title, :error_summary_items, :description

        public

        # @param title [String] text to use for the heading of the error summary block
        # @param error_summary_items [Array<Hash>] the list of errors to include in the summary. See {Components::GovUK::ErrorSummary::Item#initialize Item#initialize}
        # @param description [String] optional text to use for the description of the errors
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the error summary HTML
        # @option options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML

        def initialize(title:, error_summary_items: [], description: nil, **)
          super(**)

          @title = title
          @error_summary_items = error_summary_items.map { |error_summary_item| Item.new(context: @context, **error_summary_item) }
          @description = description
        end

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for the GOV.UK Error summary component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            tag.div(role: 'alert') do
              concat(tag.h2(title, class: 'govuk-error-summary__title'))
              concat(tag.div(class: 'govuk-error-summary__body') do
                concat(tag.p(description)) if description
                if error_summary_items.any?
                  concat(tag.ul(class: 'govuk-list govuk-error-summary__list') do
                    error_summary_items.each { |error_summary_item| concat(error_summary_item.render) }
                  end)
                end
              end)
            end
          end
        end

        # rubocop:enable Metrics/AbcSize

        # The default attributes for the error summary

        DEFAULT_ATTRIBUTES = { class: 'govuk-error-summary', data: { module: 'govuk-error-summary' } }.freeze
      end
    end
  end
end
