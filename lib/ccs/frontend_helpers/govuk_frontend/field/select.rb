# frozen_string_literal: true

require 'action_view'
require_relative '../field'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      module Field
        # = GOV.UK Select
        #
        # This helper is used for generating the select component from the
        # {https://design-system.service.gov.uk/components/select GDS - Components - Select}
        #
        # This is considered a Field module and so makes use of the methods in {CCS::FrontendHelpers::GovUKFrontend::Field}

        module Select
          include ActionView::Helpers::FormOptionsHelper
          include Field

          # Generates the HTML for the GOV.UK Select component
          #
          # @param attribute [String, Symbol] the attribute of the select field
          # @param items [Array] array of option items for the select, see {govuk_map_select_items}
          # @param govuk_select_options [Hash] options that will be used for the parts of the form group, label, hint and select
          #
          # @option govuk_select_options [String] :error_message (nil) the error message to be displayed
          # @option govuk_select_options [ActiveModel] :model (nil) optional model that can be used to find an error message
          # @option govuk_select_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
          #                                                                       the select tag and find the error message
          # @option govuk_select_options [Hash] :form_group see {govuk_field}
          # @option govuk_select_options [Hash] :label see {govuk_field}
          # @option govuk_select_options [Hash] :hint see {govuk_field}
          # @option govuk_select_options [Hash] :select ({}) the options that will be used when rendering the select field.
          #                                                  See {govuk_select_tag} for more details.
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Select
          #                                     which can then be rendered on the page

          def govuk_select(attribute, items, **govuk_select_options)
            govuk_field(:select, attribute, **govuk_select_options) do |govuk_field_options, error_message|
              initialise_attributes_and_set_classes(govuk_field_options, "govuk-select #{'govuk-select--error' if error_message}".rstrip)

              (govuk_select_options[:select] ||= {})[:selected] = govuk_select_options[:model].send(attribute) if govuk_select_options[:model]

              concat(
                if govuk_select_options[:form]
                  govuk_select_form(govuk_select_options[:form], attribute, items, **govuk_field_options)
                else
                  govuk_select_tag(attribute, items, **govuk_field_options)
                end
              )
            end
          end

          private

          # Generates the select HTML for {govuk_select}
          #
          # @param attribute [String, Symbol] the attribute of the select field
          # @param items [Array] array of option items for the select, see {govuk_map_select_items}
          # @param govuk_select_options [Hash] options that will be used in customising the HTML
          #
          # @option govuk_select_options [String] :classes additional CSS classes for the select HTML
          # @option govuk_select_options [String] :selected (nil) the selected option
          # @option govuk_select_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the select field which is used in {govuk_select}

          def govuk_select_tag(attribute, items, **govuk_select_options)
            select_tag(
              attribute,
              options_for_select(
                govuk_map_select_items(items),
                govuk_select_options[:selected]
              ),
              **govuk_select_options[:attributes]
            )
          end

          # Generates the select HTML for {govuk_select} when there is a ActionView::Helpers::FormBuilder
          #
          # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the select field
          # @param (see govuk_select_tag)
          #
          # @option (see govuk_select_tag)
          #
          # @return (see govuk_select_tag)

          def govuk_select_form(form, attribute, items, **govuk_select_options)
            form.select(
              attribute,
              govuk_map_select_items(items),
              govuk_select_options[:select_options] || {},
              **govuk_select_options[:attributes]
            )
          end

          # Maps the items into an array that can be used to generate the options for
          # {govuk_select_tag} and {govuk_select_form}
          #
          # @param items [Array] array of option items for the select
          #
          # @option items [String] :text the text of the option item.
          #                              If this is blank the value is used
          # @option items [String] :value the value of the option item
          # @option items [Hash] :attributes ({}) any additional attributes that will added as part of the option HTML
          #
          # @return [Array] array of option params that are used in {govuk_select_tag} and {govuk_select_form}

          def govuk_map_select_items(items)
            items.map do |item|
              [
                item[:text] || item[:value],
                item[:value],
                (item[:attributes] || {})
              ]
            end
          end
        end
      end
    end
  end
end
