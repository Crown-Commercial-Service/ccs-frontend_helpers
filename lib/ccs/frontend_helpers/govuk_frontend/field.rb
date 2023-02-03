# frozen_string_literal: true

require_relative 'fieldset'
require_relative 'form_group'
require_relative 'hint'
require_relative 'label'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Field
      #
      # This module contains methods to wrap the:
      # - fieldset
      # - form group
      # - label
      # - hint
      # - error message
      # around some kind of input.
      #
      # The wrapper functions in this module are used
      # to create the fields using the structure of a GDS input field component.

      module Field
        include Fieldset
        include FormGroup
        include Hint
        include Label

        # Generates the HTML to wrap arround a GDS input field component.
        #
        # @param field [Symbol] the type of the field
        # @param attribute [String, Symbol] the attribute of the field
        # @param govuk_field_options [Hash] options that will be used for the parts of the form group, label, hint and field
        #
        # @option govuk_field_options [String] :error_message (nil) the error message to be displayed
        # @option govuk_field_options [ActiveModel] :model (nil) optional model that can be used to find an error message
        # @option govuk_field_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
        #                                                                      the field and find the error message
        # @option govuk_field_options [Hash] :form_group ({}) the options for govuk_form_group {govuk_form_group}
        # @option govuk_field_options [Hash] :label the parameters that will be used to create the label for the field, see {govuk_label}
        # @option govuk_field_options [Hash] :hint (nil) the parameters that will be used to create the hint for the field, see {govuk_hint}.
        #                                                If no hint is given then no hint will be rendered
        # @option govuk_field_options [Hash] :field_options ({}) the options that will be used when rendering the field.
        #                                                        For more details look at the specific module that uses +Field+.
        #
        # @yield the field HTML
        #
        # @yieldparam govuk_field_options [Hash] the HTML options used when rendering the field
        # @yieldparam error_message [String] flag to indicate if there are any erros
        #
        # @return [ActiveSupport::SafeBuffer] the HTML that wraps arround the field

        def govuk_field(field, attribute, **govuk_field_options)
          set_label_for_if_custom_id(field, govuk_field_options)
          set_hint_id(attribute, govuk_field_options)
          error_message = find_field_error_message(attribute, govuk_field_options)

          govuk_form_group(attribute, error_message: error_message, **(govuk_field_options[:form_group] || {})) do |display_error_message|
            set_field_described_by(field, attribute, error_message, govuk_field_options)

            concat(govuk_label(attribute, govuk_field_options[:label][:text], form: govuk_field_options[:form], **govuk_field_options[:label]))
            concat(govuk_hint(govuk_field_options[:hint][:text], **govuk_field_options[:hint])) if govuk_field_options[:hint]
            concat(display_error_message)
            yield(govuk_field_options[field], error_message)
          end
        end

        # Generates the HTML to wrap arround a GDS input fields component.
        # These are inputs that require being wrapped in a fieldset, for example radio buttons.
        #
        # @param field [Symbol] the type of the fields
        # @param attribute [String, Symbol] the attribute of the fields
        # @param govuk_fields_options [Hash] options that will be used for the parts of the fieldset, form group, hint and fields
        #
        # @option govuk_fields_options [String] :error_message (nil) the error message to be displayed
        # @option govuk_fields_options [ActiveModel] :model (nil) optional model that can be used to find an error message
        # @option govuk_fields_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
        #                                                                       the field and find the error message
        # @option govuk_fields_options [Hash] :form_group ({}) the options for govuk_form_group {govuk_form_group}
        # @option govuk_fields_options [Hash] :fieldset ({}) the options for govuk_fieldset {govuk_fieldset}
        # @option govuk_fields_options [Hash] :hint (nil) the parameters that will be used to create the hint for the field, see {govuk_hint}.
        #                                                 If no hint is given then no hint will be rendered
        # @option govuk_fields_options [Hash] :field_options ({}) the options that will be used when rendering the fields.
        #                                                         For more details look at a module that uses +Field+.
        #
        # @yield the fields HTML
        #
        # @yieldparam govuk_fields_options [Hash] the HTML options used when rendering the fields
        # @yieldparam error_message [String] flag to indicate if there are any erros
        #
        # @return [ActiveSupport::SafeBuffer] the HTML that wraps arround the fields

        def govuk_fields(field, attribute, **govuk_fields_options)
          set_hint_id(attribute, govuk_fields_options)
          error_message = find_field_error_message(attribute, govuk_fields_options)

          govuk_form_group(attribute, error_message: error_message, **(govuk_fields_options[:form_group] || {})) do |display_error_message|
            set_field_described_by(:fieldset, attribute, error_message, govuk_fields_options)
            (govuk_fields_options[field] ||= {})[:attributes] ||= {}

            govuk_fieldset(**govuk_fields_options[:fieldset]) do
              concat(govuk_hint(govuk_fields_options[:hint][:text], **govuk_fields_options[:hint])) if govuk_fields_options[:hint]
              concat(display_error_message)
              yield(govuk_fields_options[field], error_message)
            end
          end
        end

        private

        # If present, will find the error message for the field
        #
        # @param attribute [String, Symbol] the attribute of the fields
        #
        # @option govuk_field_options [String] :error_message (nil) the error message to be displayed
        # @option govuk_field_options [ActiveModel] :model (nil) optional model that can be used to find an error message
        # @option govuk_field_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
        #                                                                       the field and find the error message
        #
        # @return [String] the error message

        def find_field_error_message(attribute, govuk_field_options)
          if govuk_field_options[:model]
            govuk_field_options[:model].errors[attribute].first
          elsif govuk_field_options[:form]
            govuk_field_options[:form].object.errors[attribute].first
          else
            govuk_field_options[:error_message]
          end
        end

        # Sets the label +for+ if a custom ID has been given for the field.
        #
        # @param govuk_field_options [Hash] see {govuk_field} for details

        def set_label_for_if_custom_id(field, govuk_field_options)
          field_id = govuk_field_options.dig(field, :attributes, :id)

          govuk_field_options[:label] ||= {}
          (govuk_field_options[:label][:attributes] ||= {})[:for] = field_id if field_id
        end

        # Sets the hint ID if there is a hint, and the ID for the hint has not been sent
        #
        # @param attribute [String, Symbol] the attribute of the field
        # @param govuk_field_options [Hash] see {govuk_field} for details

        def set_hint_id(attribute, govuk_field_options)
          return if !govuk_field_options[:hint] || govuk_field_options.dig(:hint, :attributes, :id)

          govuk_field_options[:hint] ||= {}
          (govuk_field_options[:hint][:attributes] ||= {})[:id] = "#{attribute}-hint"
        end

        # Adds the aira-describedby attribute for the field
        # if there is a hint or an error message
        #
        # @param attribute [String, Symbol] the attribute of the input
        # @param error_message [String] used to indicate if there is an error
        # @param govuk_field_options [Hash] see {#govuk_field} for details

        def set_field_described_by(field, attribute, error_message, govuk_field_options)
          aria_described_by = []
          aria_described_by << govuk_field_options.dig(field, :attributes, :aria, :describedby)
          aria_described_by << govuk_field_options[:hint][:attributes][:id] if govuk_field_options[:hint]
          aria_described_by << "#{attribute}-error" if error_message
          aria_described_by.compact!

          govuk_field_options[field] ||= {}
          govuk_field_options[field][:attributes] ||= {}

          return unless aria_described_by.any?

          (govuk_field_options[field][:attributes][:aria] ||= {})[:describedby] = aria_described_by.join(' ')
        end

        # Sets the hint attributes and adds the aira-describedby attribute for a fields item
        #
        # @param type [String] the type of the item
        # @param attribute [String, Symbol] the attribute of the item
        # @param item [Hash] the options for that item

        def set_item_options_for_hint(type, attribute, item)
          return unless item[:hint]

          (item[:hint] ||= {})[:attributes] ||= {}
          item[:hint][:classes] = "govuk-#{type}__hint #{item[:hint][:classes]}".rstrip
          item[:hint][:attributes][:id] ||= "#{attribute}_#{item[:value]}-item-hint"

          (item[:attributes][:aria] ||= {})[:describedby] = item[:hint][:attributes][:id]
        end

        # Sets the conditional attributes and adds the data-aira-controls attribute for a fields item
        #
        # @param type [String] the type of the item
        # @param attribute [String, Symbol] the attribute of the item
        # @param item [Hash] the options for that item

        def set_conditional_item_options(type, attribute, item)
          return unless item[:conditional]

          item[:conditional][:attributes] ||= {}
          item[:conditional][:attributes][:class] = "govuk-#{type}__conditional #{"govuk-#{type}__conditional--hidden" unless item[:checked]}".rstrip
          item[:conditional][:attributes][:id] ||= sanitize_to_id("#{attribute}_#{item[:value]}_conditional")
          (item[:attributes][:data] ||= {})[:'aria-controls'] = item[:conditional][:attributes][:id]
        end
      end
    end
  end

  ActionView::Base.field_error_proc = proc { |html_tag, _instance| html_tag }
end
