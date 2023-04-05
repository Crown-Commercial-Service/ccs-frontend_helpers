# frozen_string_literal: true

require_relative '../../components/govuk/pagination'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Pagination
      #
      # This helper is used for generating the pagination component from the
      # {https://design-system.service.gov.uk/components/pagination GDS - Components - Pagination}

      module Pagination
        # Generates the HTML for the GOV.UK Pagination component
        #
        # @param (see CCS::Components::GovUK::Pagination#initialize)
        #
        # @option (see CCS::Components::GovUK::Pagination#initialize)
        #
        # @return (see CCS::Components::GovUK::Pagination#render)

        def govuk_pagination(**options)
          Components::GovUK::Pagination.new(context: self, **options).render
        end
      end
    end
  end
end
