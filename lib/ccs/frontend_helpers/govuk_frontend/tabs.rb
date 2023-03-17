# frozen_string_literal: true

require_relative '../../components/govuk/tabs'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Tabs
    #
    # This helper is used for generating the tabs component from the
    # {https://design-system.service.gov.uk/components/tabs GDS - Components - Tabs}

    module Tabs
      # Generates the HTML for the GOV.UK Tabs component
      #
      # @param (see CCS::Components::GovUK::Tabs#initialize)
      #
      # @option (see CCS::Components::GovUK::Tabs#initialize)
      #
      # @return (see CCS::Components::GovUK::Tabs#render)

      def govuk_tabs(items, title = nil, **options)
        Components::GovUK::Tabs.new(context: self, items: items, title: title, **options).render
      end
    end
  end
end
