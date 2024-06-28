# frozen_string_literal: true

require_relative '../../components/ccs/header'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Header
      #
      # This helper is used for generating the header component from the
      # {https://github.com/Crown-Commercial-Service/ccs-frontend-project/tree/main/packages/ccs-frontend/src/ccs/components/header CCS - Components - Header}

      module Header
        # Generates the HTML for the CCS Header component
        #
        # @param (see CCS::Components::CCS::Header#initialize)
        #
        # @option (see CCS::Components::CCS::Header#initialize)
        #
        # @return (see CCS::Components::CCS::Header#render)

        def ccs_header(**options)
          Components::CCS::Header.new(context: self, **options).render
        end
      end
    end
  end
end
