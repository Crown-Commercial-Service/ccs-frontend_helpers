require_relative '../base'
require_relative 'fieldset/legend'

module CCS
  module Components
    module GovUK
      # = GOV.UK Fieldset
      #
      # This is used to generate the fieldset component from the
      # {https://design-system.service.gov.uk/components/fieldset GDS - Components - Fieldset}
      #
      # @!attribute [r] legend
      #   @return [Legend] Initialised fieldset legend

      class Fieldset < Base
        private

        attr_reader :legend

        public

        # @param legend [Hash] options for the fieldset legend.
        #                      See {Components::GovUK::Fieldset::Legend#initialize Legend#initialize} for details of the options.
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the fieldset HTML
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(legend: nil, **)
          super(**)

          @legend = Legend.new(context: @context, **legend) if legend
        end

        # Generates the HTML for the GOV.UK Fieldset component
        #
        # @yield HTML that will be contained within the 'govuk-fieldset' div and under the legend
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.fieldset(**options[:attributes]) do
            concat(legend.render) if legend
            yield if block_given?
          end
        end

        # The default attributes for the fieldset

        DEFAULT_ATTRIBUTES = { class: 'govuk-fieldset' }.freeze
      end
    end
  end
end
