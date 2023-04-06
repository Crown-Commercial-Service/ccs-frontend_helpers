# frozen_string_literal: true

require_relative '../../components/govuk/panel'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Panel
      #
      # This helper is used for generating the panel component from the
      # {https://design-system.service.gov.uk/components/panel GDS - Components - Panel}

      module Panel
        # Generates the HTML for the GOV.UK Panel component
        #
        # @param (see CCS::Components::GovUK::Panel#initialize)
        #
        # @option (see CCS::Components::GovUK::Panel#initialize)
        #
        # @yield (see CCS::Components::GovUK::Panel#render)
        #
        # @return (see CCS::Components::GovUK::Panel#render)

        def govuk_panel(title_text, panel_text = nil, **options, &block)
          Components::GovUK::Panel.new(context: self, title_text: title_text, panel_text: panel_text, **options).render(&block)
        end
      end
    end
  end
end
