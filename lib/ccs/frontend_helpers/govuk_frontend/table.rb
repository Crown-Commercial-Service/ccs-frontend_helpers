# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Table
      #
      # This helper is used for generating the table component from the
      # {https://design-system.service.gov.uk/components/table GDS - Components - Table}

      module Table
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK Table component
        #
        # @param rows [Array] array of table rows and cells. See {govuk_table_row}
        # @param head [NilClass,Array] array of table head cells. See {govuk_table_head}
        # @param govuk_table_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_table_options [String] :classes additional CSS classes for the table HTML
        # @option govuk_table_options [String] :first_cell_is_header if set to true, first cell in table row will be a TH instead of a TD
        # @option govuk_table_options [Hash] :caption options for a table caption. See {govuk_table_caption}
        # @option govuk_table_options [Hash] :attributes ({}) any additional attributes that will be added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Table
        #                                     which can then be rendered on the page

        def govuk_table(rows, head = nil, **govuk_table_options)
          initialise_attributes_and_set_classes(govuk_table_options, 'govuk-table')

          tag.table(**govuk_table_options[:attributes]) do
            concat(govuk_table_caption(govuk_table_options[:caption])) if govuk_table_options[:caption]
            concat(govuk_table_head(head)) if head
            concat(tag.tbody(class: 'govuk-table__body') do
              rows.each { |row| concat(govuk_table_row(row, govuk_table_options[:first_cell_is_header])) }
            end)
          end
        end

        private

        # Generates the HTML for the the table caption used in {govuk_table}
        #
        # @param caption [Hash] options that are used to define the caption
        #
        # @option caption [String] :text the caption text
        # @option caption [String] :classes additional CSS classes for the table caption
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the table caption used in {govuk_table}

        def govuk_table_caption(caption)
          tag.caption(caption[:text], class: "govuk-table__caption #{caption[:classes]}".rstrip)
        end

        # Generates the HTML for the table head used in {govuk_table}
        #
        # @param head [Array] an array of table head cells
        #
        # @option head [String] :text the text of the cell
        # @option head [String] :classes additional CSS classes for the cell
        # @option head [String] :format specify format of a cell
        # @option head [Hash] :attributes ({}) any additional attributes that will be added as part of the cell
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the table head used in {govuk_table}

        def govuk_table_head(head)
          tag.thead(class: 'govuk-table__head') do
            tag.tr(class: 'govuk-table__row') do
              head.each do |cell|
                initialise_attributes_and_set_classes(cell, 'govuk-table__header')

                cell[:attributes][:class] += " govuk-table__header--#{cell[:format]}" if cell[:format]
                cell[:attributes][:scope] = 'col'

                concat(tag.th(cell[:text], **cell[:attributes]))
              end
            end
          end
        end

        # Generates the HTML for a table row used in {govuk_table}
        #
        # @param row [Array] an array of a rows cells
        # @param first_cell_is_header [Boolean] if set to true, first cell in the row will be a TH instead of a TD
        #
        # @option row [String] :text the text of the cell
        # @option row [String] :classes additional CSS classes for the cell
        # @option row [String] :format specify format of a cell
        # @option row [Hash] :attributes ({}) any additional attributes that will be added as part of the cell
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for a table row used in {govuk_table}

        def govuk_table_row(row, first_cell_is_header)
          tag.tr(class: 'govuk-table__row') do
            row.each.with_index do |cell, index|
              tag_type = if first_cell_is_header && index.zero?
                           initialise_attributes_and_set_classes(cell, 'govuk-table__header')

                           cell[:attributes][:scope] = 'row'

                           :th
                         else
                           initialise_attributes_and_set_classes(cell, 'govuk-table__cell')

                           cell[:attributes][:class] += " govuk-table__cell--#{cell[:format]}" if cell[:format]

                           :td
                         end

              concat(tag.send(tag_type, cell[:text], **cell[:attributes]))
            end
          end
        end
      end
    end
  end
end
