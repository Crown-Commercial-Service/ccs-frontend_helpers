# frozen_string_literal: true

require_relative '../../components/govuk/details'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Details
      #
      # This helper is used for generating the details component from the
      # {https://design-system.service.gov.uk/components/details GDS - Components - Details}

      module Details
        # Generates the HTML for the GOV.UK Details component
        #
        # @param (see CCS::Components::GovUK::Details#initialize)
        #
        # @option (see CCS::Components::GovUK::Details#initialize)
        #
        # @yield (see CCS::Components::GovUK::Details#render)
        #
        # @return (see CCS::Components::GovUK::Details#render)

        def govuk_details(summary_text, **options, &block)
          Components::GovUK::Details.new(context: self, summary_text: summary_text, **options).render(&block)
        end
      end
    end
  end
end
