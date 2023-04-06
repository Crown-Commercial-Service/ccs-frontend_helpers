# frozen_string_literal: true

require_relative '../../components/govuk/summary_list'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Summary list
      #
      # This helper is used for generating the summary list component from the
      # {https://design-system.service.gov.uk/components/summary-list GDS - Components - Summary list}

      module SummaryList
        # Generates the HTML for the GOV.UK Summary list component
        #
        # @param (see CCS::Components::GovUK::SummaryList#initialize)
        #
        # @option (see CCS::Components::GovUK::SummaryList#initialize)
        #
        # @return (see CCS::Components::GovUK::SummaryList#render)

        def govuk_summary_list(summary_list_items, **options)
          Components::GovUK::SummaryList.new(context: self, summary_list_items: summary_list_items, **options).render
        end
      end
    end
  end
end
