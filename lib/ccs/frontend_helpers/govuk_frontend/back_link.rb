# frozen_string_literal: true

require_relative '../../components/govuk/back_link'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Back Link
      #
      # This helper is used for generating the back link component from the
      # {https://design-system.service.gov.uk/components/back-link GDS - Components - Back link}

      module BackLink
        # Generates the HTML for the GOV.UK Back link component
        #
        # @param (see CCS::Components::GovUK::BackLink#initialize)
        #
        # @option (see CCS::Components::GovUK::BackLink#initialize)
        #
        # @return (see CCS::Components::GovUK::BackLink#render)

        def govuk_back_link(text, href, **)
          Components::GovUK::BackLink.new(context: self, text: text, href: href, **).render
        end
      end
    end
  end
end
