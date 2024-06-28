# frozen_string_literal: true

require 'ccs/components/ccs/password_strength'

RSpec.describe CCS::Components::CCS::PasswordStrength do
  include_context 'and I have a view context'

  let(:password_strength_element) { Capybara::Node::Simple.new(result).find('ul.ccs-password-strength') }

  describe '.render' do
    let(:ccs_password_strength) { described_class.new(password_id: 'password', password_strength_tests: password_strength_tests, context: view_context, **options) }
    let(:result) { ccs_password_strength.render }

    let(:password_strength_tests) do
      [
        {
          type: :length,
          value: 10
        },
        {
          type: :symbol,
          value: "=+\\-^$*.[\\]{}()?\"!@#%&/\\,><':;|_~`"
        },
        {
          type: :number
        },
        {
          type: :uppercase
        },
        {
          type: :lowercase
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
          <li data-test-type="symbol" data-test-value="=+\-^$*.[\]{}()?&quot;!@#%&amp;/\,&gt;&lt;\':;|_~`" class="ccs-password-strength-test">
            at least one symbol (eg ?, !, £, %)
          </li>
          <li data-test-type="number" class="ccs-password-strength-test">
            at least one number
          </li>
          <li data-test-type="uppercase" class="ccs-password-strength-test">
            at least one capital letter
          </li>
          <li data-test-type="lowercase" class="ccs-password-strength-test">
            at least one lowercase letter
          </li>
        </ul>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the password strength' do
        expect(password_strength_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:ccs_password_strength) { described_class.new(password_id: 'password', password_strength_tests: password_strength_tests, context: view_context) }

      it 'correctly formats the HTML for the password strength' do
        expect(password_strength_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(password_strength_element[:class]).to eq('ccs-password-strength my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(password_strength_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
