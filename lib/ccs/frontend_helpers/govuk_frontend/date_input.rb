# frozen_string_literal: true

require_relative '../../components/govuk/field/inputs/date_input'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Date Input
      #
      # This helper is used for generating the date input component from the
      # {https://design-system.service.gov.uk/components/date-input GDS - Components -  Date Input}

      module DateInput
        # Generates the HTML for the GOV.UK Date Input component
        #
        # @param (see CCS::Components::GovUK::Inputs::DateInput#initialize)
        #
        # @option (see CCS::Components::GovUK::Inputs::DateInput#initialize)
        #
        # @return (see CCS::Components::GovUK::Inputs::DateInput#render)

        def govuk_date_input(attribute, **)
          Components::GovUK::Field::Inputs::DateInput.new(context: self, attribute: attribute, **).render
        end
      end
    end
  end
end
