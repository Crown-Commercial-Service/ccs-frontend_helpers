# frozen_string_literal: true

require_relative '../../components/govuk/tag'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Tag
    #
    # This helper is used for generating the tag component from the
    # {https://design-system.service.gov.uk/components/tag GDS - Components - Tag}

    module Tag
      # Generates the HTML for the GOV.UK Back link component
      #
      # @param (see CCS::Components::GovUK::Tag#initialize)
      #
      # @option (see CCS::Components::GovUK::Tag#initialize)
      #
      # @return (see CCS::Components::GovUK::Tag#render)

      def govuk_tag(text, colour = nil, **options)
        Components::GovUK::Tag.new(context: self, text: text, colour: colour, **options).render
      end
    end
  end
end
