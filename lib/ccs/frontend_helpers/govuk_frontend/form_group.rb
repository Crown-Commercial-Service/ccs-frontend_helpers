# frozen_string_literal: true

require_relative '../../components/govuk/form_group'

module CCS
  module FrontendHelpers::GovUKFrontend
    # = GOV.UK FormGroup
    #
    # This helper is used for generating the form group component from the Government Design Systems

    module FormGroup
      # Generates the HTML for the GOV.UK Warning text component
      #
      # @param (see CCS::Components::GovUK::FormGroup#initialize)
      #
      # @option options [String] :classes additional CSS classes for the form group HTML
      # @option options  [ActiveModel] :model (nil) model that will be used to find an error message
      # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
      #
      # @yield (see CCS::Components::GovUK::FormGroup#render)
      #
      # @yieldparam (see CCS::Components::GovUK::FormGroup#render)
      #
      # @return (see CCS::Components::GovUK::FormGroup#render)

      def govuk_form_group(attribute, **options, &block)
        error_message = if options[:model]
                          model.errors[attribute].first
                        else
                          options[:error_message]
                        end

        Components::GovUK::FormGroup.new(context: self, attribute: attribute, error_message: error_message, **options).render(&block)
      end
    end
  end
end
