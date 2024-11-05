# frozen_string_literal: true

require_relative '../../components/govuk/phase_banner'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Phase banner
      #
      # This helper is used for generating the phase banner component from the
      # {https://design-system.service.gov.uk/components/phase-banner GDS - Components - Phase banner}

      module PhaseBanner
        # Generates the HTML for the GOV.UK Phase banner component
        #
        # @param (see CCS::Components::GovUK::PhaseBanner#initialize)
        #
        # @option (see CCS::Components::GovUK::PhaseBanner#initialize)
        #
        # @yield (see CCS::Components::GovUK::PhaseBanner#render)
        #
        # @return (see CCS::Components::GovUK::PhaseBanner#render)

        def govuk_phase_banner(tag_options, text = nil, **options, &)
          Components::GovUK::PhaseBanner.new(context: self, tag_options: tag_options, text: text, **options).render(&)
        end
      end
    end
  end
end
