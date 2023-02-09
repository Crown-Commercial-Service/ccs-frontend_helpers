# frozen_string_literal: true

require_relative 'tag'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Phase banner
      #
      # This helper is used for generating the phase banner component from the
      # {https://design-system.service.gov.uk/components/phase-banner GDS - Components - Phase banner}

      module PhaseBanner
        include ActionView::Helpers::TextHelper
        include Tag

        # Generates the HTML for the GOV.UK Phase banner component
        #
        # @param text [String] the text for the phase banner
        # @param tag_options [Hash] paramters for the govuk tag (see {govuk_tag}).
        #                           options are:
        #                           - +text+
        #                           - +colour+
        #                           - +options+
        # @param govuk_phase_banner_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_phase_banner_options [String] :classes additional CSS classes for the phase banner HTML
        # @option govuk_phase_banner_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Phase banner
        #                                     which can then be rendered on the page

        def govuk_phase_banner(text, tag_options, **govuk_phase_banner_options)
          initialise_attributes_and_set_classes(govuk_phase_banner_options, 'govuk-phase-banner')

          tag_options[:options] ||= {}
          tag_options[:options][:classes] = "govuk-phase-banner__content__tag #{tag_options[:options][:classes]}"

          tag.div(**govuk_phase_banner_options[:attributes]) do
            tag.p(class: 'govuk-phase-banner__content') do
              concat(govuk_tag(tag_options[:text], tag_options[:colour], **tag_options[:options]))
              concat(tag.span(text, class: 'govuk-phase-banner__text'))
            end
          end
        end
      end
    end
  end
end
