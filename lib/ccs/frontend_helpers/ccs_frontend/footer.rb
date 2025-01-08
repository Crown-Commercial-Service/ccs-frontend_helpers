# frozen_string_literal: true

require_relative '../../components/ccs/footer'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Footer
      #
      # This helper is used for generating the footer component from the
      # {https://github.com/Crown-Commercial-Service/ccs-frontend-project/tree/main/packages/ccs-frontend/src/ccs/components/footer CCS - Components - Footer}

      module Footer
        # Generates the HTML for the CCS Footer component
        #
        # @param (see CCS::Components::CCS::Footer#initialize)
        #
        # @option (see CCS::Components::CCS::Footer#initialize)
        #
        # @return (see CCS::Components::CCS::Footer#render)

        def ccs_footer(**)
          Components::CCS::Footer.new(context: self, **).render
        end
      end
    end
  end
end
