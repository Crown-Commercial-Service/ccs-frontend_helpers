# frozen_string_literal: true

require 'ccs/components/ccs/password_strength/test'

RSpec.describe CCS::Components::CCS::PasswordStrength::Test, type: :helper do
  include_context 'and I have a view context'

  let(:password_strength_test_element) { Capybara::Node::Simple.new(result).find('li.ccs-password-strength-test') }

  describe '.render' do
    let(:ccs_password_strength_test) { described_class.new(type: type, context: view_context, **options) }
    let(:result) { ccs_password_strength_test.render }

    let(:options) { {} }

    context 'when the type is length' do
      let(:type) { :length }
      let(:options) { { value: 8 } }

      it 'correctly formats the HTML for password strength test' do
        expect(password_strength_test_element.to_html).to eq('
          <li data-test-type="length" data-test-value="8" class="ccs-password-strength-test">
            at least 8 characters
          </li>
        '.to_one_line)
      end

      context 'when there is custom text' do
        let(:options) { super().merge({ text: 'Custom text for length' }) }

        it 'correctly formats the HTML with the custom text' do
          expect(password_strength_test_element.to_html).to eq('
            <li data-test-type="length" data-test-value="8" class="ccs-password-strength-test">
              Custom text for length
            </li>
          '.to_one_line)
        end
      end
    end

    context 'when the type is symbol' do
      let(:type) { :symbol }
      let(:options) { { value: "=+\\-^$*.[\\]{}()?\"!@#%&/\\,><':;|_~`" } }

      it 'correctly formats the HTML for password strength test' do
        expect(password_strength_test_element.to_html).to eq('
          <li data-test-type="symbol" data-test-value="=+\-^$*.[\]{}()?&quot;!@#%&amp;/\,&gt;&lt;\':;|_~`" class="ccs-password-strength-test">
            at least one symbol (eg ?, !, £, %)
          </li>
        '.to_one_line)
      end

      context 'when there is custom text' do
        let(:options) { super().merge({ text: 'Custom text for symbol' }) }

        it 'correctly formats the HTML with the custom text' do
          expect(password_strength_test_element.to_html).to eq('
            <li data-test-type="symbol" data-test-value="=+\-^$*.[\]{}()?&quot;!@#%&amp;/\,&gt;&lt;\':;|_~`" class="ccs-password-strength-test">
              Custom text for symbol
            </li>
          '.to_one_line)
        end
      end
    end

    context 'when the type is number' do
      let(:type) { :number }

      it 'correctly formats the HTML for password strength test' do
        expect(password_strength_test_element.to_html).to eq('
          <li data-test-type="number" class="ccs-password-strength-test">
            at least one number
          </li>
        '.to_one_line)
      end

      context 'when there is custom text' do
        let(:options) { super().merge({ text: 'Custom text for number' }) }

        it 'correctly formats the HTML with the custom text' do
          expect(password_strength_test_element.to_html).to eq('
            <li data-test-type="number" class="ccs-password-strength-test">
              Custom text for number
            </li>
          '.to_one_line)
        end
      end
    end

    context 'when the type is uppercase' do
      let(:type) { :uppercase }

      it 'correctly formats the HTML for password strength test' do
        expect(password_strength_test_element.to_html).to eq('
          <li data-test-type="uppercase" class="ccs-password-strength-test">
            at least one capital letter
          </li>
        '.to_one_line)
      end

      context 'when there is custom text' do
        let(:options) { super().merge({ text: 'Custom text for uppercase' }) }

        it 'correctly formats the HTML with the custom text' do
          expect(password_strength_test_element.to_html).to eq('
            <li data-test-type="uppercase" class="ccs-password-strength-test">
              Custom text for uppercase
            </li>
          '.to_one_line)
        end
      end
    end

    context 'when the type is lowercase' do
      let(:type) { :lowercase }

      it 'correctly formats the HTML for password strength test' do
        expect(password_strength_test_element.to_html).to eq('
          <li data-test-type="lowercase" class="ccs-password-strength-test">
            at least one lowercase letter
          </li>
        '.to_one_line)
      end

      context 'when there is custom text' do
        let(:options) { super().merge({ text: 'Custom text for lowercase' }) }

        it 'correctly formats the HTML with the custom text' do
          expect(password_strength_test_element.to_html).to eq('
            <li data-test-type="lowercase" class="ccs-password-strength-test">
              Custom text for lowercase
            </li>
          '.to_one_line)
        end
      end
    end
  end
end
