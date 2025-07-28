# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/breadcrumbs'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Breadcrumbs, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_breadcrumbs from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'breadcrumbs' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with one level'" do
      let(:fixture_name) { 'with one level' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'without the home section'" do
      let(:fixture_name) { 'without the home section' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with last breadcrumb as current page'" do
      let(:fixture_name) { 'with last breadcrumb as current page' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with collapse on mobile'" do
      let(:fixture_name) { 'with collapse on mobile' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items], collapse_on_mobile: fixture_options[:collapseOnMobile]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'inverse'" do
      let(:fixture_name) { 'inverse' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'item attributes'" do
      let(:fixture_name) { 'item attributes' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items].map { |item| { href: item[:href], text: item[:html].html_safe } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom label'" do
      let(:fixture_name) { 'custom label' }
      let(:result) { govuk_breadcrumbs(fixture_options[:items], attributes: { aria: { label: fixture_options[:labelText] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
