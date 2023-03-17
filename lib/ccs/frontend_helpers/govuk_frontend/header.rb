# frozen_string_literal: true

require_relative '../../components/govuk/header'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Header
    #
    # This helper is used for generating the header component from the
    # {https://design-system.service.gov.uk/components/header GDS - Components - Header}

    module Header
      # Generates the HTML for the GOV.UK Header component
      #
      # @param (see CCS::Components::GovUK::Header#initialize)
      #
      # @option (see CCS::Components::GovUK::Header#initialize)
      #
      # @return (see CCS::Components::GovUK::Header#render)

      def govuk_header(**options)
        Components::GovUK::Header.new(context: self, **options).render
      end
    end
  end
end
