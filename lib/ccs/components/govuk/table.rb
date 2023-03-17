require_relative '../base'
require_relative 'table/body/data_cell'
require_relative 'table/body/head_cell'
require_relative 'table/header/head_cell'

module CCS::Components
  module GovUK
    # = GOV.UK Table
    #
    # This is used to generate the table component from the
    # {https://design-system.service.gov.uk/components/table GDS - Components - Table}
    #
    # @!attribute [r] rows
    #   @return [Array<Array<Body::HeadCell|Body::DataCell>>] Arrays of the initialised row cells
    # @!attribute [r] head_cells
    #   @return [Array<Header::HeadCell>] an array of the initialised header cells
    # @!attribute [r] caption
    #   @return [Hash] options for the caption

    class Table < Base
      private

      attr_reader :rows, :head_cells, :caption

      public

      # @param rows [Array<Array<Hash>>] array of table rows and cells.
      #                                  See {Components::GovUK::Table::Body::HeadCell#initialize Body::HeadCell#initialize}
      #                                  or {Components::GovUK::Table::Body::DataCell#initialize Body::DataCell#initialize} for details of the items in the array.
      # @param head_cells [NilClass,Array] array of table head cells.
      #                                    See {Components::GovUK::Table::Header::HeadCell#initialize Header::HeadCell#initialize} for details of the items in the array.
      # @param caption [NilClass,Hash] options for a table caption
      # @param first_cell_is_header [Boolean] if set to true, first cell in table row will be a TH instead of a TD
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option caption [String] :text the caption text
      # @option caption [String] :classes additional CSS classes for the table caption
      #
      # @option options [String] :classes additional CSS classes for the table HTML
      # @option options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML

      def initialize(rows:, head_cells: nil, caption: nil, first_cell_is_header: nil, **options)
        super(**options)

        @rows = rows.map do |row_cells|
          row_cells.map.with_index do |row_cell, index|
            if first_cell_is_header && index.zero?
              Body::HeadCell.new(context: @context, **row_cell)
            else
              Body::DataCell.new(context: @context, **row_cell)
            end
          end
        end
        @head_cells = head_cells&.map { |head_cell| Header::HeadCell.new(context: @context, **head_cell) }
        @caption = caption
      end

      # Generates the HTML for the GOV.UK table component
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.table(**options[:attributes]) do
          concat(table_caption) if caption
          concat(table_head) if head_cells
          concat(tag.tbody(class: 'govuk-table__body') do
            rows.each { |row_cells| concat(table_row(row_cells)) }
          end)
        end
      end

      # The default attributes for the table

      DEFAULT_ATTRIBUTES = { class: 'govuk-table' }.freeze

      private

      # Generates the HTML for the the table caption
      #
      # @return [ActiveSupport::SafeBuffer]

      def table_caption
        tag.caption(caption[:text], class: "govuk-table__caption #{caption[:classes]}".rstrip)
      end

      # Generates the HTML for the table head
      #
      # @return [ActiveSupport::SafeBuffer]

      def table_head
        tag.thead(class: 'govuk-table__head') do
          tag.tr(class: 'govuk-table__row') do
            head_cells.each { |head_cell| concat(head_cell.render) }
          end
        end
      end

      # Generates the HTML for a table row
      #
      # @return [ActiveSupport::SafeBuffer]

      def table_row(row_cells)
        tag.tr(class: 'govuk-table__row') do
          row_cells.each { |row_cell| concat(row_cell.render) }
        end
      end
    end
  end
end
