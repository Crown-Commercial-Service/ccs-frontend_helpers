require_relative '../base'
require_relative 'password_strength/test'

module CCS
  module Components
    module CCS
      # = CCS Password Strength
      #
      # This is used for generating the contact us component from the
      # {https://github.com/Crown-Commercial-Service/ccs-frontend-project/tree/main/packages/ccs-frontend/src/ccs/components/password-strength CCS - Components - Password strength}
      #
      # @!attribute [r] password_strength_tests
      #   @return [Array<Test>] An array of the initialised password strength tests

      class PasswordStrength < Base
        private

        attr_reader :password_strength_tests

        public

        # @param password_id [String] The ID for the password element that will be checked against
        # @param password_strength_tests [Array<Hash>] An array of options for the password strength tests,
        #                                               See {Components::CCS::PasswordStrength::Test#initialize Test#initialize} for details of the items in the array.
        #
        # @option options [String] :classes additional CSS classes for the password strength HTML
        # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

        def initialize(password_id:, password_strength_tests:, **options)
          super(**options)

          @options[:attributes][:data][:target] = password_id

          @password_strength_tests = password_strength_tests.map { |password_strength_test| Test.new(context: @context, **password_strength_test) }
        end

        # Generates the HTML for the CCS password strength component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.ul(**options[:attributes]) do
            password_strength_tests.each { |password_strength_test| concat(password_strength_test.render) }
          end
        end

        # The default attributes for password strength

        DEFAULT_ATTRIBUTES = { class: 'ccs-password-strength', data: { module: 'ccs-password-strength' } }.freeze
      end
    end
  end
end
