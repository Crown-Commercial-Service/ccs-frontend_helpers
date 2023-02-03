# frozen_string_literal: true

require_relative '../field'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      module Field
        # = GOV.UK File Upload
        #
        # This helper is used for generating the file upload component from the
        # {https://design-system.service.gov.uk/components/file-upload GDS - Components - File Upload}
        #
        # This is considered a Field module and so makes use of the methods in {CCS::FrontendHelpers::GovUKFrontend::Field}

        module FileUpload
          include Field

          # Generates the HTML for the GOV.UK file upload component
          #
          # @param attribute [String, Symbol] the attribute of the file upload
          # @param govuk_file_upload_options [Hash] options that will be used for the parts of the form group, label, hint and file upload
          #
          # @option govuk_file_upload_options [String] :error_message (nil) the error message to be displayed
          # @option govuk_file_upload_options [ActiveModel] :model (nil) optional model that can be used to find an error message
          # @option govuk_file_upload_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
          #                                                                            the file upload input and find the error message
          # @option govuk_file_upload_options [Hash] :form_group see {govuk_field}
          # @option govuk_file_upload_options [Hash] :label see {govuk_field}
          # @option govuk_file_upload_options [Hash] :hint see {govuk_field}
          # @option govuk_file_upload_options [Hash] :file_upload ({}) the options that will be used when rendering the file upload.
          #                                                            See {govuk_file_upload_tag} for more details.
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK File Upload
          #                                     which can then be rendered on the page

          def govuk_file_upload(attribute, **govuk_file_upload_options)
            govuk_field(:file_upload, attribute, **govuk_file_upload_options) do |govuk_field_options, error_message|
              initialise_attributes_and_set_classes(govuk_field_options, "govuk-file-upload #{'govuk-file-upload--error' if error_message}".rstrip)

              concat(
                if govuk_file_upload_options[:form]
                  govuk_file_upload_form(govuk_file_upload_options[:form], attribute, **govuk_field_options)
                else
                  govuk_file_upload_tag(attribute, **govuk_field_options)
                end
              )
            end
          end

          private

          # Generates the file upload HTML for {govuk_file_upload}
          #
          # @param attribute [String, Symbol] the attribute of the file upload
          # @param govuk_file_upload_options [Hash] options that will be used in customising the HTML
          #
          # @option govuk_file_upload_options [String] :classes additional CSS classes for the file upload HTML
          # @option govuk_file_upload_options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the file upload field which is used in {govuk_file_upload}

          def govuk_file_upload_tag(attribute, **govuk_file_upload_options)
            file_field_tag(attribute, **govuk_file_upload_options[:attributes])
          end

          # Generates the file upload HTML for {govuk_file_upload} when there is a ActionView::Helpers::FormBuilder
          #
          # @param form [ActionView::Helpers::FormBuilder] the form builder used to create the file upload input
          # @param (see govuk_file_upload_tag)
          #
          # @option (see govuk_file_upload_tag)
          #
          # @return (see govuk_file_upload_tag)

          def govuk_file_upload_form(form, attribute, **govuk_file_upload_options)
            form.file_field(attribute, **govuk_file_upload_options[:attributes])
          end
        end
      end
    end
  end
end
