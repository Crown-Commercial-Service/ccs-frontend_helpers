# frozen_string_literal: true

require_relative '../../components/govuk/field/input/textarea'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Textarea
      #
      # This helper is used for generating the textarea component from the
      # {https://design-system.service.gov.uk/components/textarea GDS - Components - Textarea}

      module Textarea
        # Generates the HTML for the GOV.UK Textarea component
        #
        # @param (see CCS::Components::GovUK::Input::Textarea#initialize)
        #
        # @option (see CCS::Components::GovUK::Input::Textarea#initialize)
        #
        # @return (see CCS::Components::GovUK::Input::Textarea#render)

        def govuk_textarea(attribute, **)
          Components::GovUK::Field::Input::Textarea.new(context: self, attribute: attribute, **).render
        end
      end
    end
  end
end
