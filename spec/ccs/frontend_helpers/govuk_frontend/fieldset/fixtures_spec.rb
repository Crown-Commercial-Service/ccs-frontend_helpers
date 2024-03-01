# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/fieldset'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Fieldset, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_fieldset from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'fieldset' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'styled as xl text'" do
      let(:fixture_name) { 'styled as xl text' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'styled as large text'" do
      let(:fixture_name) { 'styled as large text' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'styled as medium text'" do
      let(:fixture_name) { 'styled as medium text' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'styled as small text'" do
      let(:fixture_name) { 'styled as small text' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading xl'" do
      let(:fixture_name) { 'as page heading xl' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      before { fixture_options[:legend][:is_page_heading] = fixture_options[:legend][:isPageHeading] }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading l'" do
      let(:fixture_name) { 'as page heading l' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      before { fixture_options[:legend][:is_page_heading] = fixture_options[:legend][:isPageHeading] }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading m'" do
      let(:fixture_name) { 'as page heading m' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      before { fixture_options[:legend][:is_page_heading] = fixture_options[:legend][:isPageHeading] }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading s'" do
      let(:fixture_name) { 'as page heading s' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      before { fixture_options[:legend][:is_page_heading] = fixture_options[:legend][:isPageHeading] }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading without class'" do
      let(:fixture_name) { 'as page heading without class' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      before { fixture_options[:legend][:is_page_heading] = fixture_options[:legend][:isPageHeading] }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html fieldset content'" do
      let(:fixture_name) { 'html fieldset content' }
      let(:result) do
        govuk_fieldset(legend: fixture_options[:legend]) do
          concat(fixture_options[:html].html_safe)
        end
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with describedBy'" do
      let(:fixture_name) { 'with describedBy' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend], attributes: { aria: { describedBy: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      before { fixture_options[:legend][:text] = fixture_options[:legend][:html].html_safe }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'legend classes'" do
      let(:fixture_name) { 'legend classes' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'role'" do
      let(:fixture_name) { 'role' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend], attributes: { role: fixture_options[:role] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_fieldset(legend: fixture_options[:legend], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
