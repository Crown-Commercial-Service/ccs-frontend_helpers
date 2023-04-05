# frozen_string_literal: true

require_relative '../../components/govuk/field/inputs/radios'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Radios
      #
      # This helper is used for generating the radios component from the
      # {https://design-system.service.gov.uk/components/radios GDS - Components - Radios}

      module Radios
        # Generates the HTML for the GOV.UK Radios component
        #
        # @param (see CCS::Components::GovUK::Inputs::Radios#initialize)
        #
        # @option (see CCS::Components::GovUK::Inputs::Radios#initialize)
        #
        # @return (see CCS::Components::GovUK::Inputs::Radios#render)

        def govuk_radios(attribute, radio_items, **options)
          Components::GovUK::Field::Inputs::Radios.new(context: self, attribute: attribute, radio_items: radio_items, **options).render
        end
      end
    end
  end
end
