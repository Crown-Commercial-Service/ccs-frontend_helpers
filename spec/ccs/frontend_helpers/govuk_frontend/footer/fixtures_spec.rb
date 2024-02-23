# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/footer'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Footer, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_footer from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'footer' }
    let(:fixture_html) { fixture[:html].to_one_line.gsub('aclass', 'a class').gsub('pathfill', 'path fill').gsub('svgaria', 'svg aria') }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_footer }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom HTML content licence and copyright notice'" do
      let(:fixture_name) { 'with custom HTML content licence and copyright notice' }
      let(:result) { govuk_footer(content_licence: fixture_options[:contentLicence][:html].html_safe, copyright: fixture_options[:copyright][:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom text content licence and copyright notice'" do
      let(:fixture_name) { 'with custom text content licence and copyright notice' }
      let(:result) { govuk_footer(content_licence: fixture_options[:contentLicence][:text], copyright: fixture_options[:copyright][:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with meta'" do
      let(:fixture_name) { 'with meta' }
      let(:result) { govuk_footer(meta: { items: fixture_options[:meta][:items], visually_hidden_title: fixture_options[:meta][:visuallyHiddenTitle] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom meta'" do
      let(:fixture_name) { 'with custom meta' }
      let(:result) { govuk_footer(meta: { text: fixture_options[:meta][:text] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with meta links and meta content'" do
      let(:fixture_name) { 'with meta links and meta content' }
      let(:result) { govuk_footer(meta: { items: fixture_options[:meta][:items], text: fixture_options[:meta][:html].html_safe }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with default width navigation (one column)'" do
      let(:fixture_name) { 'with default width navigation (one column)' }
      let(:result) { govuk_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with default width navigation (two columns)'" do
      let(:fixture_name) { 'with default width navigation (two columns)' }
      let(:result) { govuk_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with navigation'" do
      let(:fixture_name) { 'with navigation' }
      let(:result) { govuk_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'Full GDS example'" do
      let(:fixture_name) { 'Full GDS example' }
      let(:result) { govuk_footer(navigation: fixture_options[:navigation], meta: { items: fixture_options[:meta][:items], text: fixture_options[:meta][:html].html_safe }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'Three equal columns'" do
      let(:fixture_name) { 'Three equal columns' }
      let(:result) { govuk_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_footer(attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_footer(classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with container classes'" do
      let(:fixture_name) { 'with container classes' }
      let(:result) { govuk_footer(container_classes: fixture_options[:containerClasses]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with HTML passed as text content'" do
      let(:fixture_name) { 'with HTML passed as text content' }
      let(:result) { govuk_footer(content_licence: fixture_options[:contentLicence][:text], copyright: fixture_options[:copyright][:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with empty meta'" do
      let(:fixture_name) { 'with empty meta' }
      let(:result) { govuk_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with empty meta items'" do
      let(:fixture_name) { 'with empty meta items' }
      let(:result) { govuk_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'meta html as text'" do
      let(:fixture_name) { 'meta html as text' }
      let(:result) { govuk_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with meta html'" do
      let(:fixture_name) { 'with meta html' }
      let(:result) { govuk_footer(meta: { text: fixture_options[:meta][:html].html_safe }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with meta item attributes'" do
      let(:fixture_name) { 'with meta item attributes' }
      let(:result) { govuk_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with empty navigation'" do
      let(:fixture_name) { 'with empty navigation' }
      let(:result) { govuk_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with navigation item attributes'" do
      let(:fixture_name) { 'with navigation item attributes' }
      let(:result) { govuk_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
