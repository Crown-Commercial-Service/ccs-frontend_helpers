# frozen_string_literal: true

require_relative 'ccs_frontend/footer'
require_relative 'ccs_frontend/header'
require_relative 'ccs_frontend/logo'
require_relative 'ccs_frontend/dashboard_panels'

module CCS
  module FrontendHelpers
    # This module loads in all the CCS Frontend Helper methods.
    # These are a collection of view helpers to help render CCS components

    module CCSFrontend
      include DashboardPanels
      include Footer
      include Header
      include Logo
    end
  end
end
