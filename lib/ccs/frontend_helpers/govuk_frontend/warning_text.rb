# frozen_string_literal: true

require_relative '../../components/govuk/warning_text'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Warning text
      #
      # This helper is used for generating the warning text component from the
      # {https://design-system.service.gov.uk/components/warning-text GDS - Components - Warning text}

      module WarningText
        # Generates the HTML for the GOV.UK Warning text component
        #
        # @param (see CCS::Components::GovUK::WarningText#initialize)
        #
        # @option (see CCS::Components::GovUK::WarningText#initialize)
        #
        # @yield (see CCS::Components::GovUK::WarningText#render)
        #
        # @return (see CCS::Components::GovUK::WarningText#render)

        def govuk_warning_text(text = nil, **options, &block)
          Components::GovUK::WarningText.new(context: self, text: text, **options).render(&block)
        end
      end
    end
  end
end
