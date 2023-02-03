# frozen_string_literal: true

require_relative '../field'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      module Field
        # = GOV.UK Radios
        #
        # This helper is used for generating the radios component from the
        # {https://design-system.service.gov.uk/components/radios GDS - Components - Radios}
        #
        # This is considered a Field module and so makes use of the methods in {CCS::FrontendHelpers::GovUKFrontend::Field}

        module Radios
          include Field

          # Generates the HTML for the GOV.UK Radios component
          #
          # @param attribute [String, Symbol] the attribute of the raido buttons
          # @param items [Array] array of radio items, see {_govuk_radios_fields}
          # @param govuk_radios_options [Hash] options that will be used for the parts of the fieldset, form group, hint and radio buttons
          #
          # @option govuk_radios_options [String] :error_message (nil) the error message to be displayed
          # @option govuk_radios_options [ActiveModel] :model (nil) optional model that can be used to find an error message
          # @option govuk_radios_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
          #                                                                       the radio tags and find the error message
          # @option govuk_radios_options [Hash] :form_group see {govuk_fields}
          # @option govuk_radios_options [Hash] :fieldset see {govuk_fields}
          # @option govuk_radios_options [Hash] :hint see {govuk_field}
          # @option govuk_radios_options [Hash] :radios ({}) the options that will be used when rendering the radio buttons.
          #                                                  See {govuk_radio_fields_tag} for more details.
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Radios
          #                                     which can then be rendered on the page

          def govuk_radios(attribute, items, **govuk_radios_options)
            govuk_fields(:radios, attribute, **govuk_radios_options) do |govuk_field_options|
              if govuk_radios_options[:model] || govuk_radios_options[:form]
                value = (govuk_radios_options[:model] || govuk_radios_options[:form].object).send(attribute)
                items.each { |item| item[:checked] = item[:value] == value }
              end

              concat(
                if govuk_radios_options[:form]
                  govuk_radio_fields_form(govuk_radios_options[:form], attribute, items, **govuk_field_options)
                else
                  govuk_radio_fields_tag(attribute, items, **govuk_field_options)
                end
              )
            end
          end

          private

          # Generates the radios HTML for {govuk_radios}
          #
          # @param attribute [String, Symbol] the attribute of the raido buttons
          # @param items [Array] array of radio items, see {_govuk_radios_fields}
          # @param govuk_radios_options [Hash] options that will be used in customising the HTML
          #
          # @option (see _govuk_radios_fields)
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the radio buttons which is used in {govuk_radios}

          def govuk_radio_fields_tag(attribute, items, **govuk_radios_options)
            _govuk_radios_fields(items, **govuk_radios_options) do |radio_item|
              govuk_radio_item_tag(attribute, radio_item)
            end
          end

          # Generates the radios HTML for {govuk_radios} when there is a ActionView::Helpers::FormBuilder
          #
          # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the radio buttons
          # @param (see govuk_radio_fields_tag)
          #
          # @option (see _govuk_radios_fields)
          #
          # @return (see govuk_radio_fields_tag)

          def govuk_radio_fields_form(form, attribute, items, **govuk_radios_options)
            _govuk_radios_fields(items, **govuk_radios_options) do |radio_item|
              govuk_radio_item_form(form, attribute, radio_item)
            end
          end

          # Wrapper method used by {govuk_radio_fields_tag} and {govuk_radio_fields_form} to generate the radios HTML
          #
          # @param items [Array] array of radio items.
          #                      Each item is a hash which can be:
          #                      - +:divider+ text to separate radio items
          #                      - radio item, see {_govuk_radio_item}
          # @param govuk_radios_options [Hash] options that will be used in customising the HTML
          #
          # @option govuk_radios_options [String] :classes additional CSS classes for the radios HTML
          # @option govuk_radios_options [Hash] :attributes ({ module: 'govuk-radios' }) any additional attributes that will added as part of the HTML
          #
          # @yield the radio item HTML generated by {govuk_radio_fields_tag} or {govuk_radio_fields_form}
          #
          # @yieldparam radio_item [Hash] the current radio item to be rendered
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the radio buttons which is used in {govuk_radio_fields_tag} or {govuk_radio_fields_form}

          def _govuk_radios_fields(items, **govuk_radios_options)
            initialise_attributes_and_set_classes(govuk_radios_options, 'govuk-radios')
            set_data_module(govuk_radios_options, 'govuk-radios')

            tag.div(**govuk_radios_options[:attributes]) do
              items.each do |radio_item|
                concat(
                  if radio_item[:divider]
                    tag.div(radio_item[:divider], class: 'govuk-radios__divider')
                  else
                    tag.div(class: 'govuk-radios__item') do
                      yield(radio_item)
                    end
                  end
                )
              end
            end
          end

          # Generates the HTML for a radio button for {govuk_radio_fields_form}
          #
          # @param (see _govuk_radio_item)
          #
          # @option (see _govuk_radio_item)
          #
          # @return (see _govuk_radio_item)

          def govuk_radio_item_tag(attribute, radio_item)
            _govuk_radio_item(attribute, radio_item) do
              label_attribute = radio_item[:attributes][:id] || "#{attribute}[#{radio_item[:value]}]"

              concat(radio_button_tag(attribute, radio_item[:value], radio_item[:checked], **radio_item[:attributes]))
              concat(govuk_label(label_attribute, radio_item[:label][:text], **radio_item[:label]))
            end
          end

          # Generates the HTML for a radio button for {govuk_radio_fields_tag}
          #
          # @param (see _govuk_radio_item)
          # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the radio buttons
          #
          # @option (see _govuk_radio_item)
          #
          # @return (see _govuk_radio_item)

          def govuk_radio_item_form(form, attribute, radio_item)
            _govuk_radio_item(attribute, radio_item) do
              (radio_item[:label][:attributes] ||= {})[:value] = radio_item[:value]
              radio_item[:label][:attributes][:for] = radio_item[:attributes][:id] if radio_item[:attributes][:id]

              concat(form.radio_button(attribute, radio_item[:value], **radio_item[:attributes]))
              concat(govuk_label(attribute, radio_item[:label][:text], form: form, **radio_item[:label]))
            end
          end

          # rubocop:disable Metrics/AbcSize

          # Wrapper method used by {govuk_radio_item_tag} and {govuk_radio_item_form} to generate the radios HTML
          # including the label and hint, if there is one.
          #
          # @param attribute [String, Symbol] the attribute of the raido buttons
          # @param radio_item [Hash] the options for the radio item
          #
          # @option radio_item [String] :classes additional CSS classes for the radio button HTML
          # @option radio_item [Hash] :label the parameters that will be used to create the label for the radio button, see {govuk_label}
          # @option radio_item [Hash] :hint (nil) the parameters that will be used to create the hint for the radio button, see {govuk_hint}.
          #                                          If no hint is given then no hint will be rendered
          # @option radio_item [Hash] :conditional (nil) content that will appear when the radio button is checked.
          #                                              It can have the following options:
          #                                              - +[:content]+ the content that will be shown
          #                                              - +[:attributes][:id]+ the id of the conditional section
          #                                              If no conditional is given then no conditional content will be rendered
          # @option radio_item [Hash] :attributes ({}) any additional attributes that will be added as part of the radio button HTML
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the radio buttons, label and hint
          #                                     which is used in {govuk_radio_item_tag} and {govuk_radio_item_form}

          def _govuk_radio_item(attribute, radio_item)
            (radio_item[:attributes] ||= {})[:class] = 'govuk-radios__input'

            radio_item[:label] ||= {}
            radio_item[:label][:classes] = "govuk-radios__label #{radio_item[:label][:classes]}".rstrip

            set_item_options_for_hint('radios', attribute, radio_item)
            set_conditional_item_options('radios', attribute, radio_item)

            yield
            concat(govuk_hint(radio_item[:hint][:text], **radio_item[:hint])) if radio_item[:hint]
            concat(tag.div(radio_item[:conditional][:content], class: radio_item[:conditional][:attributes][:class], id: radio_item[:conditional][:attributes][:id])) if radio_item[:conditional]
          end

          # rubocop:enable Metrics/AbcSize
        end
      end
    end
  end
end
