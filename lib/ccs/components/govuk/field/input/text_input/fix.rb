require_relative '../text_input'

module CCS::Components
  module GovUK
    class Field < Base
      class Input < Field
        class TextInput < Input
          # = GOV.UK Text Input prefix/suffix
          #
          # This is used to generate the prefix/suffix HTML for a text input
          #
          # @!attribute [r] text
          #   @return [String] Text for the prefix/suffix

          class Fix < Base
            private

            attr_reader :text

            public

            # @param text [String] the text for the prefix/suffix
            # @param fix [String] either +"pre"+ or +"suf"+
            #
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the prefix/suffix HTML
            # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

            def initialize(text:, fix:, **options)
              super(**options)

              @options[:attributes][:class] = "govuk-input__#{fix}fix #{@options[:attributes][:class]}".rstrip
              (@options[:attributes][:aria] ||= {})[:hidden] = true

              @text = text
            end

            # Generates the HTML for the GOV.UK Text Input prefix/suffix
            #
            # @yield (see CCS::Components::GovUK::Field#render)
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.div(text, **options[:attributes])
            end
          end
        end
      end
    end
  end
end
