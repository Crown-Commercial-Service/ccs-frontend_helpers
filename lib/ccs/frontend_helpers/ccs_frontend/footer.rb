# frozen_string_literal: true

require_relative '../../components/ccs/footer'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Footer
      #
      # This helper is used for generating the footer component from the
      # {https://github.com/tim-s-ccs/ts-ccs-frontend/tree/main/src/ccs/components/footer CCS - Components - Footer}

      module Footer
        # Generates the HTML for the CCS Footer component
        #
        # @param (see CCS::Components::CCS::Footer#initialize)
        #
        # @option (see CCS::Components::CCS::Footer#initialize)
        #
        # @return (see CCS::Components::CCS::Footer#render)

        def ccs_footer(**options)
          Components::CCS::Footer.new(context: self, **options).render
        end
      end
    end
  end
end
