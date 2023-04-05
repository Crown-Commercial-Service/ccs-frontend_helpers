# frozen_string_literal: true

require_relative '../../components/govuk/breadcrumbs'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Breadcrumbs
      #
      # This helper is used for generating the breadcrumbs component from the
      # {https://design-system.service.gov.uk/components/breadcrumbs GDS - Components - Breadcrumbs}

      module Breadcrumbs
        # Generates the HTML for the GOV.UK breadcrumbs component
        #
        # @param (see CCS::Components::GovUK::Breadcrumbs#initialize)
        #
        # @option (see CCS::Components::GovUK::Breadcrumbs#initialize)
        #
        # @return (see CCS::Components::GovUK::Breadcrumbs#render)

        def govuk_breadcrumbs(breadcrumb_links, **options)
          Components::GovUK::Breadcrumbs.new(context: self, breadcrumb_links: breadcrumb_links, **options).render
        end
      end
    end
  end
end
