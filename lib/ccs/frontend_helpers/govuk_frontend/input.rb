# frozen_string_literal: true

require_relative '../../components/govuk/field/input/text_input'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Input
      #
      # This helper is used for generating the input component from the
      # {https://design-system.service.gov.uk/components/text-input GDS - Components - Text Input}

      module Input
        # Generates the HTML for the GOV.UK Text Input component
        #
        # @param (see CCS::Components::GovUK::Input::TextInput#initialize)
        #
        # @option (see CCS::Components::GovUK::Input::TextInput#initialize)
        #
        # @return (see CCS::Components::GovUK::Input::TextInput#render)

        def govuk_input(attribute, **)
          Components::GovUK::Field::Input::TextInput.new(context: self, attribute: attribute, **).render
        end
      end
    end
  end
end
