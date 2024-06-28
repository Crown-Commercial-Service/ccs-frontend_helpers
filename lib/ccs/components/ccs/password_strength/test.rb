require_relative '../../base'

module CCS
  module Components
    module CCS
      class PasswordStrength < Base
        # = CCS Password Strength Test
        #
        # The individual test within the password strength list
        #
        # @!attribute [r] text
        #   @return [Symbol] Text for the tes

        class Test < Base
          private

          attr_reader :text

          public

          # @param type [Symbol] The type of the test, one of: length, symbol, number, uppercase, lowercase
          # @param text [String] Optional text for the test. If not given then a default will be used
          # @param text [value] This is required if type is length and is the required length of the password.
          #                     This is required if type is symbol and is the list of allowed symbols.

          def initialize(context:, type:, text: nil, value: nil)
            super(context: context, attributes: { data: { 'test-type': type } })

            default_text = case type
                           when :length
                             @options[:attributes][:data]['test-value'] = value
                             "at least #{value} characters"
                           when :symbol
                             @options[:attributes][:data]['test-value'] = value
                             'at least one symbol (eg ?, !, £, %)'
                           when :number
                             'at least one number'
                           when :uppercase
                             'at least one capital letter'
                           when :lowercase
                             'at least one lowercase letter'
                           end

            @text = text || default_text
          end

          # Generates the HTML for the CCS Password Strength Test
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.li(text, **options[:attributes])
          end

          # The default attributes for the password strength test

          DEFAULT_ATTRIBUTES = { class: 'ccs-password-strength-test' }.freeze
        end
      end
    end
  end
end
