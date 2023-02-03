# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Fieldset
      #
      # This helper is used for generating the fieldset component from the
      # {https://design-system.service.gov.uk/components/fieldset GDS - Components - Fieldset}

      module Fieldset
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK Fieldset component
        #
        # @param govuk_fieldset_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_fieldset_options [String] :classes additional CSS classes for the fieldset HTML
        # @option govuk_fieldset_options [Hash] :legend options for the legend which are used in {#govuk_legend}
        # @option govuk_fieldset_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @yield HTML that will be contained within the 'govuk-fieldset' div and under the legend
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Fieldset
        #                                     which can then be rendered on the page

        def govuk_fieldset(**govuk_fieldset_options)
          initialise_attributes_and_set_classes(govuk_fieldset_options, 'govuk-fieldset')

          tag.fieldset(**govuk_fieldset_options[:attributes]) do
            concat(govuk_legend(govuk_fieldset_options[:legend])) if govuk_fieldset_options[:legend]
            yield
          end
        end

        private

        # Generates the HTML for the Legend as part of {#govuk_fieldset}
        #
        # @param govuk_legend_options [Hash] options that will be used in the legend
        #
        # @option govuk_legend_options [String] :classes additional CSS classes for the legend HTML
        # @option govuk_legend_options [String] :text the text for the legend
        # @option govuk_legend_options [boolean] :is_page_heading (false) if the legend is also the heading it will rendered in a h1
        # @option govuk_legend_options [Hash] :caption an optional hash with the +text+ and +classes+ that will be used
        #                                              to render a caption before the h1 if the legend is a page heading
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Fieldset
        #                                     which can then be rendered on the page

        def govuk_legend(govuk_legend_options)
          tag.legend(class: "govuk-fieldset__legend #{govuk_legend_options[:classes]}".rstrip) do
            if govuk_legend_options[:is_page_heading]
              concat(tag.span(govuk_legend_options[:caption][:text], class: govuk_legend_options[:caption][:classes])) if govuk_legend_options[:caption]
              concat(tag.h1(govuk_legend_options[:text], class: 'govuk-fieldset__heading'))
            else
              govuk_legend_options[:text]
            end
          end
        end
      end
    end
  end
end
