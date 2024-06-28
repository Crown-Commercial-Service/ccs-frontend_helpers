# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/password_strength'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::PasswordStrength, '#helpers', type: :helper do
  include described_class

  let(:password_strength_element) { Capybara::Node::Simple.new(result).find('ul.ccs-password-strength') }

  describe '.ccs_password_strength' do
    let(:result) { ccs_password_strength('password', password_strength_tests, **options) }

    let(:password_strength_tests) do
      [
        {
          type: :length,
          value: 10
        }
      ]
    end

    let(:options) { {} }

    let(:default_html) do
      '
        <ul class="ccs-password-strength" data-module="ccs-password-strength" data-target="password">
          <li data-test-type="length" data-test-value="10" class="ccs-password-strength-test">
            at least 10 characters
          </li>
        </ul>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the password strength component' do
        expect(password_strength_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { ccs_password_strength('password', password_strength_tests) }

      it 'correctly formats the HTML for the password strength component' do
        expect(password_strength_element.to_html).to eq(default_html)
      end
    end
  end
end
