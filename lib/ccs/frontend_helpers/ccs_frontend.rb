# frozen_string_literal: true

require_relative 'ccs_frontend/contact_us'
require_relative 'ccs_frontend/dashboard_section'
require_relative 'ccs_frontend/footer'
require_relative 'ccs_frontend/header'
require_relative 'ccs_frontend/logo'
require_relative 'ccs_frontend/password_strength'

module CCS
  module FrontendHelpers
    # This module loads in all the CCS Frontend Helper methods.
    # These are a collection of view helpers to help render CCS components

    module CCSFrontend
      include ContactUs
      include DashboardSection
      include Footer
      include Header
      include Logo
      include PasswordStrength
    end
  end
end
