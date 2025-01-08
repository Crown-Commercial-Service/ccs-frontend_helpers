# frozen_string_literal: true

require_relative '../../components/govuk/label'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK label
      #
      # This helper is used for generating the label component from the Government Design Systems

      module Label
        # Generates the HTML for the GOV.UK label component
        #
        # @param (see CCS::Components::GovUK::Label#initialize)
        #
        # @option (see CCS::Components::GovUK::Label#initialize)
        #
        # @yield (see CCS::Components::GovUK::Label#render)
        #
        # @return (see CCS::Components::GovUK::Label#render)

        def govuk_label(attribute, text = nil, **, &)
          Components::GovUK::Label.new(context: self, attribute: attribute, text: text, **).render(&)
        end
      end
    end
  end
end
