# frozen_string_literal: true

require_relative '../../components/govuk/skip_link'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Skip Link
    #
    # This helper is used for generating the skip link component from the
    # {https://design-system.service.gov.uk/components/skip-link GDS - Components - Skip link}

    module SkipLink
      # Generates the HTML for the GOV.UK Skip link component
      #
      # @param (see CCS::Components::GovUK::SkipLink#initialize)
      #
      # @option (see CCS::Components::GovUK::SkipLink#initialize)
      #
      # @return (see CCS::Components::GovUK::SkipLink#render)

      def govuk_skip_link(text, href = nil, **options)
        Components::GovUK::SkipLink.new(context: self, text: text, href: href, **options).render
      end
    end
  end
end
