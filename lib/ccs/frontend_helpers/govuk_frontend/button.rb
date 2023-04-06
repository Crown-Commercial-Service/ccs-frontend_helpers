# frozen_string_literal: true

require_relative '../../components/govuk/button'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Button
      #
      # This helper is used for generating the button component from the
      # {https://design-system.service.gov.uk/components/button GDS - Components - Button}

      module Button
        # Generates the HTML for the GOV.UK button component
        #
        # @param (see CCS::Components::GovUK::Button#initialize)
        #
        # @option (see CCS::Components::GovUK::Button#initialize)
        #
        # @return (see CCS::Components::GovUK::Button#render)

        def govuk_button(text, **options)
          Components::GovUK::Button.new(context: self, text: text, **options).render
        end
      end
    end
  end
end
