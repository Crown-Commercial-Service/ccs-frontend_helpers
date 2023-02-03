# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Accordion
      #
      # This helper is used for generating the accordion component from the
      # {https://design-system.service.gov.uk/accordion/back-link GDS - Components - Accordion}

      module Accordion
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK accordion component
        #
        # @param accordion_id [String] used as an id in the HTML for the accordion as a whole,
        #                              and also as a prefix for the ids of the section contents
        #                              and the buttons that open them
        # @param accordion_items [Array<Hash>] an array of accordion items.
        #                                      See {#govuk_accordion_section} for details of the items in the array.
        # @param govuk_accordion_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_accordion_options [String] :classes additional CSS classes for the accordion HTML
        # @option govuk_accordion_options [Integer] :heading_level (2) heading level, from 1 to 6
        # @option govuk_accordion_options [Hash] :attributes ({ data: { module: 'govuk-accordion' } }) any additional
        #                                                    attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Accordion
        #                                     which can then be rendered on the page

        def govuk_accordion(accordion_id, accordion_items, **govuk_accordion_options)
          initialise_attributes_and_set_classes(govuk_accordion_options, 'govuk-accordion')
          set_data_module(govuk_accordion_options, 'govuk-accordion')

          govuk_accordion_options[:attributes][:id] = accordion_id
          govuk_accordion_options[:heading_level] ||= 2

          tag.div(**govuk_accordion_options[:attributes]) do
            accordion_items.each.with_index(1) { |accordion_item, index| concat(govuk_accordion_section(accordion_id, accordion_item, index, govuk_accordion_options[:heading_level])) }
          end
        end

        private

        # Generates the HTML for an accordion section, used by {govuk_accordion}
        #
        # @param accordion_id [String] used as an id in the HTML for the accordion
        # @param index [Integer] the index of the accordion item
        # @param heading_level [Integer] heading level, from 1 to 6
        #
        # @option accordion_item [Boolean] :expanded sets whether the section should be expanded
        #                                            when the page loads for the first time.
        # @option accordion_item [String] :heading_level (2) Heading level, from 1 to 6
        # @option accordion_item [String] :heading the heading text for the accordion
        # @option accordion_item [String] :summary (nil) optional summary text for the accordion header
        # @option accordion_item [String, ActiveSupport::SafeBuffer] the content within the accordion section
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for an accordion section
        #                                     which is used in {govuk_accordion}

        def govuk_accordion_section(accordion_id, accordion_item, index, heading_level)
          tag.div(class: "govuk-accordion__section #{'govuk-accordion__section--expanded' if accordion_item[:expanded]}".rstrip) do
            concat(govuk_accordion_section_header(accordion_id, accordion_item, index, heading_level))
            concat(govuk_accordion_section_content(accordion_id, accordion_item, index))
          end
        end

        # Generates the HTML for an accordion section heading, used by {govuk_accordion_section}
        #
        # @param (see govuk_accordion_section)
        #
        # @option (see govuk_accordion_section)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for an accordion section heading
        #                                     which is used in {govuk_accordion_section}

        def govuk_accordion_section_header(accordion_id, accordion_item, index, heading_level)
          tag.div(class: 'govuk-accordion__section-header') do
            concat(tag.send("h#{heading_level}", class: 'govuk-accordion__section-heading') do
              tag.span(accordion_item[:heading], class: 'govuk-accordion__section-button', id: "#{accordion_id}-heading-#{index}")
            end)
            concat(tag.div(accordion_item[:summary], class: 'govuk-accordion__section-summary govuk-body', id: "#{accordion_id}-summary-#{index}")) if accordion_item[:summary]
          end
        end

        # Generates the HTML for an accordion sections content, used by {govuk_accordion_section}
        #
        # @param accordion_id [String] used as an id in the HTML for the accordion
        # @param index [Integer] the index of the accordion item
        #
        # @option (see govuk_accordion_section)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for an accordion sections content
        #                                     which is used in {govuk_accordion_section}

        def govuk_accordion_section_content(accordion_id, accordion_item, index)
          tag.div(class: 'govuk-accordion__section-content', id: "#{accordion_id}-content-#{index}", aria: { labelledby: "#{accordion_id}-heading-#{index}" }) do
            if accordion_item[:content].is_a? ActiveSupport::SafeBuffer
              accordion_item[:content]
            else
              tag.p(accordion_item[:content], class: 'govuk-body')
            end
          end
        end
      end
    end
  end
end
