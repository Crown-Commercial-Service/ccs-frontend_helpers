# frozen_string_literal: true

require_relative '../../components/govuk/field/input/text_input'

module CCS
  module FrontendHelpers::GovUKFrontend
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

      def govuk_input(attribute, **options)
        Components::GovUK::Field::Input::TextInput.new(context: self, attribute: attribute, **options).render
      end
    end
  end
end
