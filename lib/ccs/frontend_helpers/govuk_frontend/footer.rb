# frozen_string_literal: true

require_relative '../../components/govuk/footer'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Footer
      #
      # This helper is used for generating the footer component from the
      # {https://design-system.service.gov.uk/components/footer GDS - Components - Footer}

      module Footer
        # Generates the HTML for the GOV.UK Footer component
        #
        # @param (see CCS::Components::GovUK::Footer#initialize)
        #
        # @option (see CCS::Components::GovUK::Footer#initialize)
        #
        # @return (see CCS::Components::GovUK::Footer#render)

        def govuk_footer(**)
          Components::GovUK::Footer.new(context: self, **).render
        end
      end
    end
  end
end
