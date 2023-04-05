# frozen_string_literal: true

require_relative '../../components/govuk/hint'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Hint
      #
      # This helper is used for generating the hint text component from the Government Design Systems

      module Hint
        # Generates the HTML for the GOV.UK Hint component
        #
        # @param (see CCS::Components::GovUK::Hint#initialize)
        #
        # @option (see CCS::Components::GovUK::Hint#initialize)
        #
        # @yield (see CCS::Components::GovUK::Hint#render)
        #
        # @return (see CCS::Components::GovUK::Hint#render)

        def govuk_hint(text = nil, **options, &block)
          Components::GovUK::Hint.new(context: self, text: text, **options).render(&block)
        end
      end
    end
  end
end
