# frozen_string_literal: true

require_relative '../../components/govuk/step_by_step_navigation'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK Step by step navigation
    #
    # This helper is used for generating the Step by step navigation component from the
    # {https://design-system.service.gov.uk/patterns/step-by-step-navigation/ GDS - Pages - Step by step navigation}
    #
    # To use this component you need the following from {https://github.com/alphagov/govuk_publishing_components GOV.UK Publishing Components}.
    # For the SCSS components you should add:
    # - {https://github.com/alphagov/govuk_publishing_components/blob/main/app/assets/stylesheets/govuk_publishing_components/components/_step-by-step-nav.scss _step-by-step-nav.scss}
    # - {https://github.com/alphagov/govuk_publishing_components/blob/main/app/assets/stylesheets/govuk_publishing_components/components/_step-by-step-nav-related.scss _step-by-step-nav-related.scss}
    # - {https://github.com/alphagov/govuk_publishing_components/blob/main/app/assets/stylesheets/govuk_publishing_components/components/_step-by-step-nav-header.scss _step-by-step-nav-header.scss}
    # For the JavaScript you should add:
    # - {https://github.com/alphagov/govuk_publishing_components/blob/main/app/assets/javascripts/govuk_publishing_components/components/step-by-step-nav.js step-by-step-nav.js}

    module StepByStepNavigation
      # Generates the HTML for the GOV.UK Step by step navigation component
      #
      # @param (see CCS::Components::GovUK::StepByStepNavigation#initialize)
      #
      # @option (see CCS::Components::GovUK::StepByStepNavigation#initialize)
      #
      # @return (see CCS::Components::GovUK::StepByStepNavigation#render)

      def govuk_step_by_step_navigation(step_by_step_navigation_sections, **options)
        Components::GovUK::StepByStepNavigation.new(context: self, step_by_step_navigation_sections: step_by_step_navigation_sections, **options).render
      end
    end
  end
end
