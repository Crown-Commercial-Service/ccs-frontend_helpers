# frozen_string_literal: true

require_relative '../../components/govuk/field/input/password_input'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Password input
      #
      # This helper is used for generating the password input component from the
      # {https://design-system.service.gov.uk/components/password-input GDS - Components - Password Input}

      module PasswordInput
        # Generates the HTML for the GOV.UK Password Input component
        #
        # @param (see CCS::Components::GovUK::Input::PasswordInput#initialize)
        #
        # @option (see CCS::Components::GovUK::Input::PasswordInput#initialize)
        #
        # @return (see CCS::Components::GovUK::Input::PasswordInput#render)

        def govuk_password_input(attribute, **options)
          Components::GovUK::Field::Input::PasswordInput.new(context: self, attribute: attribute, **options).render
        end
      end
    end
  end
end
