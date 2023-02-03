# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend'
require 'ccs/frontend_helpers/govuk_frontend'

require_relative 'frontend_helpers/version'

module CCS
  # = CCS Frontend Helpers
  #
  # The CCS Frontend Helperss module contains view helpers based on:
  # - {https://design-system.service.gov.uk/components GDS components}
  # - {https://github.com/tim-s-ccs/ts-ccs-frontend CCS components}
  # that can be used in Ruby on Rails projects within CCS.

  module FrontendHelpers
    include CCSFrontend
    include GovUKFrontend
  end
end
