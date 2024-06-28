# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/password_strength'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::PasswordStrength, '#fixtures', type: :helper do
  include described_class

  describe '.ccs_password_strength from fixtures' do
    include_context 'and I have loaded the CCS Frontend fixture'

    let(:component_name) { 'password-strength' }

    before do
      fixture_options[:tests].each do |password_strength_test|
        password_strength_test[:type] = password_strength_test[:type].to_sym
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with symbol test'" do
      let(:fixture_name) { 'with symbol test' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with number test'" do
      let(:fixture_name) { 'with number test' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with uppercase test'" do
      let(:fixture_name) { 'with uppercase test' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with lowercase test'" do
      let(:fixture_name) { 'with lowercase test' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with all the tests'" do
      let(:fixture_name) { 'with all the tests' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom text for all the tests'" do
      let(:fixture_name) { 'with custom text for all the tests' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { ccs_password_strength(fixture_options[:passwordId], fixture_options[:tests], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
