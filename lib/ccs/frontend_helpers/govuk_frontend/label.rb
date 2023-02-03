# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK label
      #
      # This helper is used for generating the label component from the Government Design Systems

      module Label
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::FormTagHelper

        # Generates the HTML for the GOV.UK label component
        #
        # @param attribute [String, Symbol] the attribute of the input that requires a label
        # @param label_text [String] the label text, it is ignored if a block is given
        # @param govuk_label_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_label_options [String] :classes additional CSS classes for the label HTML
        # @option govuk_label_options [Boolean] :is_page_heading (false) if the legend is also the heading it will rendered in a h1
        # @option govuk_label_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create the label
        # @option govuk_label_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @yield HTML that will be contained within the 'govuk-label' label. Ignored if label text is given
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Label
        #                                     which can then be rendered on the page

        def govuk_label(attribute, label_text = nil, **govuk_label_options, &block)
          initialise_attributes_and_set_classes(govuk_label_options, 'govuk-label')

          label_html = if govuk_label_options[:form]
                         govuk_label_form(attribute, label_text, **govuk_label_options, &block)
                       else
                         govuk_label_tag(attribute, label_text, **govuk_label_options, &block)
                       end

          if govuk_label_options[:is_page_heading]
            tag.h1(label_html, class: 'govuk-label-wrapper')
          else
            label_html
          end
        end

        private

        # Generates the HTML for the GOV.UK label component
        # using the inbuilt rails method +label+
        #
        # @param (see govuk_label)
        #
        # @option (see govuk_label)
        #
        # @yield (see govuk_label)
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Label
        #                                     which can then be rendered on the page

        def govuk_label_tag(attribute, label_text, **govuk_label_options)
          label_tag(attribute, **govuk_label_options[:attributes]) do
            label_text || yield
          end
        end

        # Generates the HTML for the GOV.UK label component
        # using the inbuilt rails ActionView::Helpers::FormBuilder
        #
        # @param (see govuk_label)
        #
        # @option (see govuk_label)
        #
        # @yield (see govuk_label)
        #
        # @return (see govuk_label_tag)

        def govuk_label_form(attribute, label_text, **govuk_label_options)
          govuk_label_options[:form].label(attribute, **govuk_label_options[:attributes]) do
            label_text || yield
          end
        end
      end
    end
  end
end
