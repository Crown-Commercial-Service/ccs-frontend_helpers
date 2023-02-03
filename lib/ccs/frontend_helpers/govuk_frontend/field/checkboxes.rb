# frozen_string_literal: true

require_relative '../field'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      module Field
        # = GOV.UK Checkboxes
        #
        # This helper is used for generating the checkboxes component from the
        # {https://design-system.service.gov.uk/components/checkboxes GDS - Components - Checkboxes}
        #
        # This is considered a Field module and so makes use of the methods in {CCS::FrontendHelpers::GovUKFrontend::Field}

        module Checkboxes
          include Field

          # Generates the HTML for the GOV.UK Checkboxes component
          #
          # @param attribute [String, Symbol] the attribute of the raido buttons
          # @param items [Array] array of checkbox items, see {_govuk_checkboxes_fields}
          # @param govuk_checkboxes_options [Hash] options that will be used for the parts of the fieldset, form group, hint and checkbox buttons
          #
          # @option govuk_checkboxes_options [String] :error_message (nil) the error message to be displayed
          # @option govuk_checkboxes_options [ActiveModel] :model (nil) optional model that can be used to find an error message
          # @option govuk_checkboxes_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
          #                                                                           the checkbox tags and find the error message
          # @option govuk_checkboxes_options [Hash] :form_group see {govuk_fields}
          # @option govuk_checkboxes_options [Hash] :fieldset see {govuk_fields}
          # @option govuk_checkboxes_options [Hash] :hint see {govuk_field}
          # @option govuk_checkboxes_options [Hash] :checkboxes ({}) the options that will be used when rendering the checkbox buttons.
          #                                                                  See {_govuk_checkboxes_fields} for more details.
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Checkboxes
          #                                     which can then be rendered on the page

          def govuk_checkboxes(attribute, items, **govuk_checkboxes_options)
            govuk_fields(:checkboxes, attribute, **govuk_checkboxes_options) do |govuk_field_options|
              if govuk_checkboxes_options[:model] || govuk_checkboxes_options[:form]
                values = (govuk_checkboxes_options[:model] || govuk_checkboxes_options[:form].object).send(attribute) || []
                items.each { |item| item[:checked] = values.include?(item[:value]) }
              end

              concat(
                if govuk_checkboxes_options[:form]
                  govuk_checkbox_field_form(govuk_checkboxes_options[:form], attribute, items, **govuk_field_options)
                else
                  govuk_checkbox_field_tag(attribute, items, **govuk_field_options)
                end
              )
            end
          end

          private

          # Generates the checkboxes HTML for {govuk_checkboxes}
          #
          # @param attribute [String, Symbol] the attribute of the raido buttons
          # @param items [Array] array of checkbox items, see {_govuk_checkboxes_fields}
          # @param govuk_checkboxes_options [Hash] options that will be used in customising the HTML
          #
          # @option (see _govuk_checkboxes_fields)
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the checkbox buttons which is used in {govuk_checkboxes}

          def govuk_checkbox_field_tag(attribute, items, **govuk_checkboxes_options)
            _govuk_checkboxes_fields(items, **govuk_checkboxes_options) do |checkbox_item|
              govuk_checkbox_item_tag(attribute, checkbox_item)
            end
          end

          # Generates the checkboxes HTML for {govuk_checkboxes} when there is a ActionView::Helpers::FormBuilder
          #
          # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the checkbox buttons
          # @param (see govuk_checkbox_field_tag)
          #
          # @option (see _govuk_checkboxes_fields)
          #
          # @return (see govuk_checkbox_field_tag)

          def govuk_checkbox_field_form(form, attribute, items, **govuk_checkboxes_options)
            _govuk_checkboxes_fields(items, **govuk_checkboxes_options) do |checkbox_item|
              govuk_checkbox_item_form(form, attribute, checkbox_item)
            end
          end

          # Wrapper method used by {govuk_checkbox_field_tag} and {govuk_checkbox_field_form} to generate the checkboxes HTML
          #
          # @param items [Array] array of checkbox items.
          #                      Each item is a hash which can be:
          #                      - +:divider+ text to separate checkbox items
          #                      - checkbox item, see {_govuk_checkbox_item}
          # @param govuk_checkboxes_options [Hash] options that will be used in customising the HTML
          #
          # @option govuk_checkboxes_options [String] :classes additional CSS classes for the checkboxes HTML
          # @option govuk_checkboxes_options [Hash] :attributes ({ module: 'govuk-checkboxes' }) any additional attributes that will added as part of the HTML
          #
          # @yield the checkbox item HTML generated by {govuk_checkbox_field_tag} or {govuk_checkbox_field_form}
          #
          # @yieldparam checkbox_item [Hash] the current checkbox item to be rendered
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the checkbox buttons which is used in {govuk_checkbox_field_tag} or {govuk_checkbox_field_form}

          def _govuk_checkboxes_fields(items, **govuk_checkboxes_options)
            initialise_attributes_and_set_classes(govuk_checkboxes_options, 'govuk-checkboxes')
            set_data_module(govuk_checkboxes_options, 'govuk-checkboxes')

            tag.div(**govuk_checkboxes_options[:attributes]) do
              items.each do |checkbox_item|
                concat(
                  if checkbox_item[:divider]
                    tag.div(checkbox_item[:divider], class: 'govuk-checkboxes__divider')
                  else
                    tag.div(class: 'govuk-checkboxes__item') do
                      yield(checkbox_item)
                    end
                  end
                )
              end
            end
          end

          # Generates the HTML for a checkbox button for {govuk_checkbox_field_form}
          #
          # @param (see _govuk_checkbox_item)
          #
          # @option (see _govuk_checkbox_item)
          #
          # @return (see _govuk_checkbox_item)

          def govuk_checkbox_item_tag(attribute, checkbox_item)
            _govuk_checkbox_item(attribute, checkbox_item) do
              checkbox_item[:attributes][:id] ||= "#{sanitize_to_id(attribute)}_#{sanitize_to_id(checkbox_item[:value])}"

              concat(check_box_tag("#{attribute}[]", checkbox_item[:value], checkbox_item[:checked], **checkbox_item[:attributes]))
              concat(govuk_label(checkbox_item[:attributes][:id], checkbox_item[:label][:text], **checkbox_item[:label]))
            end
          end

          # Generates the HTML for a checkbox button for {govuk_checkbox_field_tag}
          #
          # @param (see _govuk_checkbox_item)
          # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the checkbox buttons
          #
          # @option (see _govuk_checkbox_item)
          #
          # @return (see _govuk_checkbox_item)

          def govuk_checkbox_item_form(form, attribute, checkbox_item)
            _govuk_checkbox_item(attribute, checkbox_item) do
              (checkbox_item[:label][:attributes] ||= {})[:value] = checkbox_item[:value]
              checkbox_item[:label][:attributes][:for] = checkbox_item[:attributes][:id] if checkbox_item[:attributes][:id]

              concat(form.check_box(attribute, checkbox_item[:attributes].merge({ multiple: true, include_hidden: false }), checkbox_item[:value]))
              concat(govuk_label(attribute, checkbox_item[:label][:text], form: form, **checkbox_item[:label]))
            end
          end

          # rubocop:disable Metrics/AbcSize

          # Wrapper method used by {govuk_checkbox_item_tag} and {govuk_checkbox_item_form} to generate the checkboxes HTML
          # including the label and hint, if there is one.
          #
          # @param attribute [String, Symbol] the attribute of the raido buttons
          # @param checkbox_item [Hash] the options for the checkbox item
          #
          # @option checkbox_item [String] :classes additional CSS classes for the checkbox button HTML
          # @option checkbox_item [Hash] :label the parameters that will be used to create the label for the checkbox button, see {govuk_label}
          # @option checkbox_item [Hash] :hint (nil) the parameters that will be used to create the hint for the checkbox button, see {govuk_hint}.
          #                                          If no hint is given then no hint will be rendered
          # @option checkbox_item [Hash] :conditional (nil) content that will appear when the checkbox input is checked.
          #                                                 It can have the following options:
          #                                                 - +[:content]+ the content that will be shown
          #                                                 - +[:attributes][:id]+ the id of the conditional section
          #                                                 If no conditional is given then no conditional content will be rendered
          # @option checkbox_item [Hash] :attributes ({}) any additional attributes that will be added as part of the checkbox button HTML
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the checkbox buttons, label and hint
          #                                     which is used in {govuk_checkbox_item_tag} and {govuk_checkbox_item_form}

          def _govuk_checkbox_item(attribute, checkbox_item)
            (checkbox_item[:attributes] ||= {})[:class] = 'govuk-checkboxes__input'
            checkbox_item[:label] ||= {}
            checkbox_item[:label][:classes] = "govuk-checkboxes__label #{checkbox_item[:label][:classes]}".rstrip

            set_item_options_for_hint('checkboxes', attribute, checkbox_item)
            set_conditional_item_options('checkboxes', attribute, checkbox_item)

            yield
            concat(govuk_hint(checkbox_item[:hint][:text], **checkbox_item[:hint])) if checkbox_item[:hint]
            concat(tag.div(checkbox_item[:conditional][:content], class: checkbox_item[:conditional][:attributes][:class], id: checkbox_item[:conditional][:attributes][:id])) if checkbox_item[:conditional]
          end

          # rubocop:enable Metrics/AbcSize
        end
      end
    end
  end
end
