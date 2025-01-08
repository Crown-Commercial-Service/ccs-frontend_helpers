# frozen_string_literal: true

require_relative '../../components/govuk/cookie_banner'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Cookie Banner
      #
      # This helper is used for generating the cookie banner component from the
      # {https://design-system.service.gov.uk/components/cookie-banner GDS - Components - Cookie banner}

      module CookieBanner
        # Generates the HTML for the GOV.UK Cookie banner component
        #
        # @param (see CCS::Components::GovUK::CookieBanner#initialize)
        #
        # @option (see CCS::Components::GovUK::CookieBanner#initialize)
        #
        # @return (see CCS::Components::GovUK::CookieBanner#render)

        def govuk_cookie_banner(messages, **)
          Components::GovUK::CookieBanner.new(context: self, messages: messages, **).render
        end
      end
    end
  end
end
