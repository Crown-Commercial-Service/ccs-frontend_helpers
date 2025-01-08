# frozen_string_literal: true

require_relative '../../components/govuk/notification_banner'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Notification Banner
      #
      # This helper is used for generating the notification banner component from the
      # {https://design-system.service.gov.uk/components/notification-banner GDS - Components - Notification banner}

      module NotificationBanner
        # Generates the HTML for the GOV.UK Notification banner component
        #
        # @param (see CCS::Components::GovUK::NotificationBanner#initialize)
        #
        # @option (see CCS::Components::GovUK::NotificationBanner#initialize)
        #
        # @yield (see CCS::Components::GovUK::NotificationBanner#render)
        #
        # @return (see CCS::Components::GovUK::NotificationBanner#render)

        def govuk_notification_banner(text = nil, success_banner = nil, **, &)
          Components::GovUK::NotificationBanner.new(context: self, text: text, success_banner: success_banner, **).render(&)
        end
      end
    end
  end
end
