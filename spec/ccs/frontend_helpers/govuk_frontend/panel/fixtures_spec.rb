# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/panel'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Panel, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_panel from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'panel' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_panel(fixture_options[:titleHtml], fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom heading level'" do
      let(:fixture_name) { 'custom heading level' }
      let(:result) { govuk_panel(fixture_options[:titleText], fixture_options[:text], heading_level: fixture_options[:headingLevel]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'title html as text'" do
      let(:fixture_name) { 'title html as text' }
      let(:result) { govuk_panel(fixture_options[:titleText], fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'title html'" do
      let(:fixture_name) { 'title html' }
      let(:result) { govuk_panel(fixture_options[:titleHtml].html_safe, fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'body html as text'" do
      let(:fixture_name) { 'body html as text' }
      let(:result) { govuk_panel(fixture_options[:titleText], fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'body html'" do
      let(:fixture_name) { 'body html' }
      let(:result) { govuk_panel(fixture_options[:titleText], fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_panel(fixture_options[:titleText], fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_panel(fixture_options[:titleText], fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'title with no body text'" do
      let(:fixture_name) { 'title with no body text' }
      let(:result) { govuk_panel(fixture_options[:titleText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
