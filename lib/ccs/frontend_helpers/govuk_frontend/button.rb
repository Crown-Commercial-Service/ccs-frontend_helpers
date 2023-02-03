# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Button
      #
      # This helper is used for generating the button component from the
      # {https://design-system.service.gov.uk/components/button GDS - Components - Button}

      module Button
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper
        include ActionView::Helpers::FormTagHelper

        # Generates the HTML for the GOV.UK button component
        #
        # @param text [String] the text that will be shown in the button
        # @param govuk_button_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_button_options [String] :classes additional CSS classes for the button HTML
        # @option govuk_button_options [Boolean] :is_start_button indicates if it is a start button
        # @option govuk_button_options [String] :href the URI that will be used in anchor tag
        # @option govuk_button_options [ActionView::Helpers::FormBuilder] :form the form builder used to create the submit button
        # @option govuk_button_options [Hash] :attributes ({ data: { module: 'govuk-button' } }) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Button
        #                                     which can then be rendered on the page

        def govuk_button(text, **govuk_button_options)
          initialise_attributes_and_set_classes(govuk_button_options, 'govuk-button')
          set_data_module(govuk_button_options, 'govuk-button')

          govuk_button_options[:attributes][:class] << ' govuk-button--disabled' if govuk_button_options[:attributes][:disabled]
          govuk_button_options[:attributes][:class] << ' govuk-button--start' if govuk_button_options[:is_start_button]

          button_method = if govuk_button_options[:href]
                            :govuk_button_link
                          elsif govuk_button_options[:form]
                            :govuk_button_submit
                          else
                            :govuk_button_button
                          end

          send(button_method, text, **govuk_button_options)
        end

        private

        # Generates the HTML for the GOV.UK button component as an anchor tag.
        # It is called by {#govuk_button} which will pass in the parameters, including any defaults.
        #
        # @param text [String] the text that will be shown in the button
        # @param govuk_button_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_button_options [Boolean] :is_start_button indicates if it is a start button
        # @option govuk_button_options [String] :href the URI that will be used in anchor tag
        # @option govuk_button_options [Hash] :attributes any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Button as an anchor element
        #                                     which can then be rendered on the page

        def govuk_button_link(text, **govuk_button_options)
          govuk_button_options[:attributes][:role] = :button
          govuk_button_options[:attributes][:draggable] = false

          link_to(govuk_button_options[:href], **govuk_button_options[:attributes]) do
            concat(text)
            concat(govuk_start_button_icon) if govuk_button_options[:is_start_button]
          end
        end

        # Generates the HTML for the GOV.UK button component as a button.
        # It is called by {#govuk_button} which will pass in the parameters, including any defaults.
        #
        # @param text [String] the text that will be shown in the button
        # @param govuk_button_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_button_options [Boolean] :is_start_button indicates if it is a start button
        # @option govuk_button_options [Hash] :attributes any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Button as a button element
        #                                     which can then be rendered on the page

        def govuk_button_button(text, **govuk_button_options)
          button_tag(**govuk_button_options[:attributes]) do
            concat(text)
            concat(govuk_start_button_icon) if govuk_button_options[:is_start_button]
          end
        end

        # Generates the HTML for the GOV.UK button component as an input.
        # It is called by {#govuk_button} which will pass in the parameters, including any defaults.
        #
        # @param text [String] the text that will be shown in the input
        # @param govuk_button_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_button_options [ActionView::Helpers::FormBuilder] :form the form builder used to create the submit button
        # @option govuk_button_options [Hash] :attributes any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Button as an input element
        #                                     which can then be rendered on the page

        def govuk_button_submit(text, **govuk_button_options)
          govuk_button_options[:form].submit(text, **govuk_button_options[:attributes])
        end

        # Generates the arrow for the start button option as part of {#govuk_button}
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the arrow for the start button

        def govuk_start_button_icon
          tag.svg(class: 'govuk-button__start-icon', xmlns: 'http://www.w3.org/2000/svg', width: 17.5, height: 19, viewBox: '0 0 33 40', aria: { hidden: true }, focusable: false) do
            tag.path(fill: 'currentColor', d: 'M0 0h13l20 20-20 20H0l20-20z')
          end
        end
      end
    end
  end
end
