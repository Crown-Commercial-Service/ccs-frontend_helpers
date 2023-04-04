# frozen_string_literal: true

require_relative '../../components/govuk/table'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Table
    #
    # This helper is used for generating the table component from the
    # {https://design-system.service.gov.uk/components/table GDS - Components - Table}

    module Table
      # Generates the HTML for the GOV.UK Table component
      #
      # @param (see CCS::Components::GovUK::Table#initialize)
      #
      # @option (see CCS::Components::GovUK::Table#initialize)
      #
      # @return (see CCS::Components::GovUK::Table#render)

      def govuk_table(rows, head_cells = nil, **options)
        Components::GovUK::Table.new(context: self, rows: rows, head_cells: head_cells, **options).render
      end
    end
  end
end
