# frozen_string_literal: true

require_relative '../../components/ccs/logo'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Logo
      #
      # This helper is used for generating the logo component from the
      # {https://github.com/Crown-Commercial-Service/ccs-frontend-project/tree/main/packages/ccs-frontend/src/ccs/components/logo CCS - Components - Logo}

      module Logo
        # Generates the HTML for the CCS Logo component
        #
        # @return (see CCS::Components::CCS::Logo#render)

        def ccs_logo(**)
          Components::CCS::Logo.new(context: self, **).render
        end
      end
    end
  end
end
