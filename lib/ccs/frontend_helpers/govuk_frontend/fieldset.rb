# frozen_string_literal: true

require_relative '../../components/govuk/fieldset'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Fieldset
    #
    # This helper is used for generating the fieldset component from the
    # {https://design-system.service.gov.uk/components/fieldset GDS - Components - Fieldset}

    module Fieldset
      # Generates the HTML for the GOV.UK Fieldset component
      #
      # @param (see CCS::Components::GovUK::Fieldset#initialize)
      #
      # @option (see CCS::Components::GovUK::Fieldset#initialize)
      #
      # @yield (see CCS::Components::GovUK::Fieldset#render)
      #
      # @return (see CCS::Components::GovUK::Fieldset#render)

      def govuk_fieldset(**options, &block)
        Components::GovUK::Fieldset.new(context: self, **options).render(&block)
      end
    end
  end
end
