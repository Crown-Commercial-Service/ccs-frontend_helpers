# frozen_string_literal: true

require_relative '../../components/ccs/password_strength'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Password Strength
      #
      # This helper is used for generating the password strength component from the
      # {https://github.com/Crown-Commercial-Service/ccs-frontend-project/tree/main/packages/ccs-frontend/src/ccs/components/contact-us CCS - Components - Password Strength}

      module PasswordStrength
        # Generates the HTML for the CCS Password Strength component
        #
        # @param (see CCS::Components::CCS::PasswordStrength#initialize)
        #
        # @option (see CCS::Components::CCS::PasswordStrength#initialize)
        #
        # @return (see CCS::Components::CCS::PasswordStrength#render)

        def ccs_password_strength(password_id, password_strength_tests, **options)
          Components::CCS::PasswordStrength.new(password_id: password_id, password_strength_tests: password_strength_tests, context: self, **options).render
        end
      end
    end
  end
end
