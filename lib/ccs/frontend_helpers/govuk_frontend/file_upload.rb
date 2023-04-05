# frozen_string_literal: true

require_relative '../../components/govuk/field/input/file_upload'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK File Upload
      #
      # This helper is used for generating the file upload component from the
      # {https://design-system.service.gov.uk/components/file-upload GDS - Components - File Upload}

      module FileUpload
        # Generates the HTML for the GOV.UK File Upload component
        #
        # @param (see CCS::Components::GovUK::Input::FileUpload#initialize)
        #
        # @option (see CCS::Components::GovUK::Input::FileUpload#initialize)
        #
        # @return (see CCS::Components::GovUK::Input::FileUpload#render)

        def govuk_file_upload(attribute, **options)
          Components::GovUK::Field::Input::FileUpload.new(context: self, attribute: attribute, **options).render
        end
      end
    end
  end
end
