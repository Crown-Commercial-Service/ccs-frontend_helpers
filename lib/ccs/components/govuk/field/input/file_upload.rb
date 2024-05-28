require_relative '../input'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Input < Field
          # = GOV.UK File Upload
          #
          # This is used for generating the file upload component from the
          # {https://design-system.service.gov.uk/components/file-upload GDS - Components - File Upload}

          class FileUpload < Input
            # @param (see CCS::Components::GovUK::Field::Input#initialize)
            #
            # @option (see CCS::Components::GovUK::Field::Input#initialize)

            # Generates the HTML for the GOV.UK File Upload component
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              super do
                if options[:form]
                  options[:form].file_field(attribute, **options[:attributes])
                else
                  context.file_field_tag(attribute, **options[:attributes])
                end
              end
            end

            # The default attributes for the file upload

            DEFAULT_ATTRIBUTES = { class: 'govuk-file-upload' }.freeze
          end
        end
      end
    end
  end
end
