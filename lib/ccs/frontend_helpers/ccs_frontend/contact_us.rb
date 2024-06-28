# frozen_string_literal: true

require_relative '../../components/ccs/contact_us'

module CCS
  module FrontendHelpers
    module CCSFrontend
      # = CCS Contact Us
      #
      # This helper is used for generating the contact us component from the
      # {https://github.com/Crown-Commercial-Service/ccs-frontend-project/tree/main/packages/ccs-frontend/src/ccs/components/contact-us CCS - Components - Contact Us}

      module ContactUs
        # Generates the HTML for the CCS Contact Us component
        #
        # @param (see CCS::Components::CCS::ContactUs#initialize)
        #
        # @option (see CCS::Components::CCS::ContactUs#initialize)
        #
        # @return (see CCS::Components::CCS::ContactUs#render)

        def ccs_contact_us(contact_us_link_href, **options)
          Components::CCS::ContactUs.new(contact_us_link_href: contact_us_link_href, context: self, **options).render
        end
      end
    end
  end
end
