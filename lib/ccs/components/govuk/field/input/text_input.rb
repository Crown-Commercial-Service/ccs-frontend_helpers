require_relative '../input'
require_relative 'text_input/fix'

module CCS
  module Components
    module GovUK
      class Field < Base
        class Input < Field
          # = GOV.UK Input
          #
          # This is used for generating the input component from the
          # {https://design-system.service.gov.uk/components/text-input GDS - Components - Text Input}
          #
          # @!attribute [r] field_type
          #   @return [Symbol,String] The input field type
          # @!attribute [r] value
          #   @return [String] The value of the text input
          # @!attribute [r] prefix
          #   @return [Fix] The initialised prefix
          # @!attribute [r] suffix
          #   @return [Fix] The initialised suffix
          # @!attribute [r] input_wrapper_html_options
          #   @return [Fix] HTML options for the input wrapper

          class TextInput < Input
            private

            attr_reader :field_type, :value, :prefix, :suffix, :input_wrapper_html_options

            public

            # rubocop:disable Metrics/ParameterLists

            # @param (see CCS::Components::GovUK::Field::Input#initialize)
            # @param field_type [Symbol,String] (:text) the input field type
            # @param value [String] the value if the input
            # @param prefix [Hash] optional prefix for the input field,
            #                      see {CCS::Components::GovUK::Field::Input::TextInput::Fix#initialize Fix#initialize} for more details.
            # @param suffix [Hash] optional suffix for the input field,
            #                      see {CCS::Components::GovUK::Field::Input::TextInput::Fix#initialize Fix#initialize} for more details.
            # @param input_wrapper [Hash] HTML options for the input wrapper
            #
            # @option (see CCS::Components::GovUK::Field::Input#initialize)

            def initialize(attribute:, field_type: :text, value: nil, prefix: nil, suffix: nil, input_wrapper: {}, **options)
              super(attribute: attribute, **options)

              @field_type = :"#{field_type}_field"
              @value = @options[:model] ? @options[:model].send(attribute) : value
              @prefix = Fix.new(fix: 'pre', context: @context, **prefix) if prefix
              @suffix = Fix.new(fix: 'suf', context: @context, **suffix) if suffix
              @input_wrapper_html_options = {
                class: "govuk-input__wrapper #{input_wrapper[:classes]}".rstrip
              }.merge(input_wrapper[:attributes] || {})
            end

            # rubocop:enable Metrics/ParameterLists
            # rubocop:disable Metrics/AbcSize

            # Generates the HTML for the GOV.UK Text Input component
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              form_group.render do |display_error_message|
                concat(label.render)
                concat(hint.render) if hint
                concat(display_error_message)
                concat(text_input_wrapper do
                  if options[:form]
                    options[:form].send(field_type, attribute, **options[:attributes])
                  else
                    context.send("#{field_type}_tag", attribute, value, **options[:attributes])
                  end
                end)
              end
            end

            # The default attributes for the text input

            DEFAULT_ATTRIBUTES = { class: 'govuk-input' }.freeze

            private

            # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

            # Wrapper method used by {render} to wrap the text input with a prefix or suffix if they exist
            #
            # @yield the text input HTML
            #
            # @return [ActiveSupport::SafeBuffer]

            def text_input_wrapper
              if prefix || suffix || before_input || after_input
                tag.div(**input_wrapper_html_options) do
                  concat(before_input) if before_input
                  concat(prefix.render) if prefix
                  concat(yield)
                  concat(suffix.render) if suffix
                  concat(after_input) if after_input
                end
              else
                yield
              end
            end

            # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
          end
        end
      end
    end
  end
end
