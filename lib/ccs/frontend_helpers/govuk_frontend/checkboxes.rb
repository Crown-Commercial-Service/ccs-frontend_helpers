# frozen_string_literal: true

require_relative '../../components/govuk/field/inputs/checkboxes'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Checkboxes
      #
      # This helper is used for generating the checkboxes component from the
      # {https://design-system.service.gov.uk/components/checkboxes GDS - Components - Checkboxes}

      module Checkboxes
        # Generates the HTML for the GOV.UK Checkboxes component
        #
        # @param (see CCS::Components::GovUK::Inputs::Checkboxes#initialize)
        #
        # @option (see CCS::Components::GovUK::Inputs::Checkboxes#initialize)
        #
        # @return (see CCS::Components::GovUK::Inputs::Checkboxes#render)

        def govuk_checkboxes(attribute, checkbox_items, **)
          Components::GovUK::Field::Inputs::Checkboxes.new(context: self, attribute: attribute, checkbox_items: checkbox_items, **).render
        end
      end
    end
  end
end
