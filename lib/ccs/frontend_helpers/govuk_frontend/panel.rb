# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Panel
      #
      # This helper is used for generating the panel component from the
      # {https://design-system.service.gov.uk/components/panel GDS - Components - Panel}

      module Panel
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK Panel component
        #
        # @param title_text [String] title text for the panel which will be contained in haeding tags
        # @param panel_text [String] text to use within the panel component
        # @param govuk_panel_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_panel_options [String] :classes additional CSS classes for the panel HTML
        # @option govuk_panel_options [Integer,String] :heading_level (default: 1) heading level for the panel title text
        # @option govuk_panel_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @yield HTML that will be contained within the panel body. Ignored if panel text is given
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Panel
        #                                     which can then be rendered on the page

        def govuk_panel(title_text, panel_text = nil, **govuk_panel_options)
          initialise_attributes_and_set_classes(govuk_panel_options, 'govuk-panel govuk-panel--confirmation')

          tag.div(**govuk_panel_options[:attributes]) do
            concat(tag.send(:"h#{govuk_panel_options[:heading_level] || 1}", title_text))
            if panel_text || block_given?
              concat(tag.div(class: 'govuk-panel__body') do
                panel_text || yield
              end)
            end
          end
        end
      end
    end
  end
end
