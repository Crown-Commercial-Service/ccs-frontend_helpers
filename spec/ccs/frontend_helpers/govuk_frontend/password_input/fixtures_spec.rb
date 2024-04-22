# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/password_input'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::PasswordInput, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_password_input from fixtures' do
    include_context 'and I have loaded the fixture'
    include_context 'and I am using a field fixture'

    let(:component_name) { 'password-input' }

    before do
      fixture_options[:name] ||= fixture_options[:id]

      %i[id autocomplete].each do |attribute|
        next if fixture_options[attribute].nil?

        fixture_options[:attributes] ||= {}
        fixture_options[:attributes][attribute] = fixture_options[attribute]
        fixture_options.delete(attribute)
      end

      %i[label].each do |fix|
        next unless fixture_options.dig(fix, :html)

        fixture_options[fix][:text] = fixture_options[fix][:html].html_safe
        fixture_options[fix].delete(:html)
      end

      fixture_html.gsub!("#{fixture_options[:attributes][:id]}-hint", "#{fixture_options[:name]}-hint") if fixture_options[:hint]
      fixture_html.gsub!("#{fixture_options[:attributes][:id]}-error", "#{fixture_options[:name]}-error") if fixture_options[:errorMessage]
      fixture_html.gsub!('<button ', '<button name="button" ')
      fixture_html.gsub!('hidden>', 'hidden="hidden">')
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint text'" do
      let(:fixture_name) { 'with hint text' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message'" do
      let(:fixture_name) { 'with error message' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with label as page heading'" do
      let(:fixture_name) { 'with label as page heading' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      before do
        fixture_options[:label][:is_page_heading] = fixture_options[:label][:isPageHeading]
        fixture_options[:label].delete(:isPageHeading)
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with input width class'" do
      let(:fixture_name) { 'with input width class' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with new-password autocomplete'" do
      let(:fixture_name) { 'with new-password autocomplete' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with translations'" do
      let(:fixture_name) { 'with translations' }
      let(:result) do
        govuk_password_input(
          fixture_options[:name],
          label: fixture_options[:label],
          attributes: fixture_options[:attributes],
          show_password_text: fixture_options[:showPasswordText],
          hide_password_text: fixture_options[:hidePasswordText],
          show_password_aria_label_text: fixture_options[:showPasswordAriaLabelText],
          hide_password_aria_label_text: fixture_options[:hidePasswordAriaLabelText],
          password_shown_announcement_text: fixture_options[:passwordShownAnnouncementText],
          password_hidden_announcement_text: fixture_options[:passwordHiddenAnnouncementText]
        )
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'value'" do
      let(:fixture_name) { 'value' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], value: fixture_options[:value], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with describedBy'" do
      let(:fixture_name) { 'with describedBy' }
      let(:result) { govuk_password_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes].merge({ aria: { describedby: fixture_options[:describedBy] } })) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
