# frozen_string_literal: true

require_relative '../../components/govuk/field/input/select'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Select
    #
    # This helper is used for generating the select component from the
    # {https://design-system.service.gov.uk/components/select GDS - Components - Select}

    module Select
      # Generates the HTML for the GOV.UK Select component
      #
      # @param (see CCS::Components::GovUK::Input::Select#initialize)
      #
      # @option (see CCS::Components::GovUK::Input::Select#initialize)
      #
      # @return (see CCS::Components::GovUK::Input::Select#render)

      def govuk_select(attribute, items, **options)
        Components::GovUK::Field::Input::Select.new(context: self, attribute: attribute, items: items, **options).render
      end
    end
  end
end
