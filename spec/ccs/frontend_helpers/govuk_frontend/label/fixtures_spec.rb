# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/label'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Label, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_label from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'label' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_label(nil, fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with bold text'" do
      let(:fixture_name) { 'with bold text' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'styled as xl text'" do
      let(:fixture_name) { 'styled as xl text' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'styled as large text'" do
      let(:fixture_name) { 'styled as large text' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'styled as medium text'" do
      let(:fixture_name) { 'styled as medium text' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'styled as small text'" do
      let(:fixture_name) { 'styled as small text' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading xl'" do
      let(:fixture_name) { 'as page heading xl' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes], is_page_heading: fixture_options[:isPageHeading]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading l'" do
      let(:fixture_name) { 'as page heading l' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes], is_page_heading: fixture_options[:isPageHeading]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading m'" do
      let(:fixture_name) { 'as page heading m' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes], is_page_heading: fixture_options[:isPageHeading]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading s'" do
      let(:fixture_name) { 'as page heading s' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes], is_page_heading: fixture_options[:isPageHeading]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as page heading without class'" do
      let(:fixture_name) { 'as page heading without class' }
      let(:result) { govuk_label(nil, fixture_options[:text], is_page_heading: fixture_options[:isPageHeading]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_label(nil, fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_label(nil, fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) do
        govuk_label(nil) do
          concat(fixture_options[:html].html_safe)
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'for'" do
      let(:fixture_name) { 'for' }
      let(:result) { govuk_label(fixture_options[:for], fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_label(nil, fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
