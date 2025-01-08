# frozen_string_literal: true

require_relative '../../components/govuk/accordion'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Accordion
      #
      # This helper is used for generating the accordion component from the
      # {https://design-system.service.gov.uk/components/accordion GDS - Components - Accordion}

      module Accordion
        # Generates the HTML for the GOV.UK Accordion component
        #
        # @param (see CCS::Components::GovUK::Accordion#initialize)
        #
        # @option (see CCS::Components::GovUK::Accordion#initialize)
        #
        # @return (see CCS::Components::GovUK::Accordion#render)

        def govuk_accordion(accordion_id, accordion_sections, **)
          Components::GovUK::Accordion.new(context: self, accordion_id: accordion_id, accordion_sections: accordion_sections, **).render
        end
      end
    end
  end
end
