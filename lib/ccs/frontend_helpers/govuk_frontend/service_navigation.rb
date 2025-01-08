# frozen_string_literal: true

require_relative '../../components/govuk/service_navigation'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Service Navigation
      #
      # This helper is used for generating the service navigation component from the
      # {https://design-system.service.gov.uk/components/service-navigation GDS - Components - Service navigations}

      module ServiceNavigation
        # Generates the HTML for the GOV.UK Service navigation component
        #
        # @param (see CCS::Components::GovUK::ServiceNavigation#initialize)
        #
        # @option (see CCS::Components::GovUK::ServiceNavigation#initialize)
        #
        # @return (see CCS::Components::GovUK::ServiceNavigation#render)

        def govuk_service_navigation(**)
          Components::GovUK::ServiceNavigation.new(context: self, **).render
        end
      end
    end
  end
end
