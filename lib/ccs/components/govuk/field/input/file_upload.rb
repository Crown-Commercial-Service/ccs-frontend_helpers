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
          #
          # @!attribute [r] javascript
          #   @return [Boolean] Used to enable JavaScript enhancements for the component
          # @!attribute [r] file_upload_javascript_options
          #   @return [Hash] HTML options for the JavaScript part of file upload

          class FileUpload < Input
            private

            attr_reader :javascript, :file_upload_javascript_options

            public

            # @param (see CCS::Components::GovUK::Field::Upload#initialize)
            # @param javascript [Boolean] used to enable JavaScript enhancements for the component
            #
            # @option (see CCS::Components::GovUK::Field::Upload#initialize)

            def initialize(attribute:, javascript: false, **)
              super(attribute: attribute, **)

              @javascript = javascript

              return unless javascript

              @file_upload_javascript_options = {
                class: 'govuk-drop-zone',
                data: {
                  module: 'govuk-file-upload'
                }
              }

              %i[choose_files_button no_file_chosen multiple_files_chosen drop_instruction entered_drop_zone left_drop_zone].each do |data_attribute|
                data_attribute_name = :"#{data_attribute}_text"
                if options[data_attribute_name]
                  if options[data_attribute_name].is_a? Hash
                    options[data_attribute_name].each do |key, value|
                      @file_upload_javascript_options[:data][:"i18n.#{data_attribute.to_s.gsub('_', '-')}.#{key}"] = value
                    end
                  else
                    @file_upload_javascript_options[:data][:"i18n.#{data_attribute.to_s.gsub('_', '-')}"] = options[data_attribute_name]
                  end
                end
              end
            end

            # @param (see CCS::Components::GovUK::Field::Input#initialize)
            #
            # @option (see CCS::Components::GovUK::Field::Input#initialize)

            # Generates the HTML for the GOV.UK File Upload component
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              super do
                javascript_wrapper do
                  if options[:form]
                    options[:form].file_field(attribute, **options[:attributes])
                  else
                    context.file_field_tag(attribute, **options[:attributes])
                  end
                end
              end
            end

            # The default attributes for the file upload

            DEFAULT_ATTRIBUTES = { class: 'govuk-file-upload' }.freeze

            private

            def javascript_wrapper(&)
              if javascript
                tag.div(**file_upload_javascript_options, &)
              else
                yield
              end
            end
          end
        end
      end
    end
  end
end
