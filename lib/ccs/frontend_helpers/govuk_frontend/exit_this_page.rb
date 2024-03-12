# frozen_string_literal: true

require_relative '../../components/govuk/exit_this_page'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Exit this page
      #
      # This is used to generate the exit this page component from the
      # {https://design-system.service.gov.uk/components/exit-this-page GDS - Components - Exit this page}

      module ExitThisPage
        # Generates the HTML for the GOV.UK Exit this page component
        #
        # @param (see CCS::Components::GovUK::ExitThisPage#initialize)
        #
        # @option (see CCS::Components::GovUK::ExitThisPage#initialize)
        #
        # @return (see CCS::Components::GovUK::ExitThisPage#render)

        def govuk_exit_this_page(text = nil, redirect_url = nil, **options)
          Components::GovUK::ExitThisPage.new(context: self, text: text, redirect_url: redirect_url, **options).render
        end
      end
    end
  end
end
