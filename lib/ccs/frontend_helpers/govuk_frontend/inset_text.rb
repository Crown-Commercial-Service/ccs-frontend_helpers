# frozen_string_literal: true

require_relative '../../components/govuk/inset_text'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Inset Text
      #
      # This helper is used for generating the inset text component from the
      # {https://design-system.service.gov.uk/components/inset-text GDS - Components - Inset text}

      module InsetText
        # Generates the HTML for the GOV.UK Inset text component
        #
        # @param (see CCS::Components::GovUK::InsetText#initialize)
        #
        # @option (see CCS::Components::GovUK::InsetText#initialize)
        #
        # @yield (see CCS::Components::GovUK::InsetText#render)
        #
        # @return (see CCS::Components::GovUK::InsetText#render)

        def govuk_inset_text(text = nil, **options, &)
          Components::GovUK::InsetText.new(context: self, text: text, **options).render(&)
        end
      end
    end
  end
end
