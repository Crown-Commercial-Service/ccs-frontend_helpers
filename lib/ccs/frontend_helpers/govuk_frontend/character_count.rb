# frozen_string_literal: true

require_relative '../../components/govuk/field/input/character_count'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Character count
      #
      # This helper is used for generating the character count component from the
      # {https://design-system.service.gov.uk/components/character-count GDS - Components - Character count}

      module CharacterCount
        # Generates the HTML for the GOV.UK Character count component
        #
        # @param (see CCS::Components::GovUK::Input::CharacterCount#initialize)
        #
        # @option (see CCS::Components::GovUK::Input::CharacterCount#initialize)
        #
        # @return (see CCS::Components::GovUK::Input::CharacterCount#render)

        def govuk_character_count(attribute, character_count_options, **options)
          Components::GovUK::Field::Input::CharacterCount.new(context: self, attribute: attribute, character_count_options: character_count_options, **options).render
        end
      end
    end
  end
end
