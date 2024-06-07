# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/footer'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Footer, '#fixtures', type: :helper do
  include described_class

  describe '.ccs_footer from fixtures' do
    include_context 'and I have loaded the CCS Frontend fixture'

    let(:component_name) { 'footer' }
    let(:fixture_html) { fixture[:html].to_one_line.gsub('aclass', 'a class').gsub('"govuk-width-container "', '"govuk-width-container"') }

    before do
      if fixture_options[:meta]
        if fixture_options[:meta][:visuallyHiddenTitle]
          fixture_options[:meta][:visually_hidden_title] = fixture_options[:meta][:visuallyHiddenTitle]
          fixture_options[:meta].delete(:visuallyHiddenTitle)
        end
        if fixture_options[:meta][:html]
          fixture_options[:meta][:text] = fixture_options[:meta][:html].html_safe
          fixture_options[:meta].delete(:html)
        end
      end

      [
        'govuk-width-container',
        'ccs-footer__inline-list',
        'ccs-footer__list'
      ].each do |class_name|
        fixture_html.gsub!("class=\"#{class_name} \"", "class=\"#{class_name}\"")
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { ccs_footer }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with meta'" do
      let(:fixture_name) { 'with meta' }
      let(:result) { ccs_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom meta'" do
      let(:fixture_name) { 'with custom meta' }
      let(:result) { ccs_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with meta links and meta content'" do
      let(:fixture_name) { 'with meta links and meta content' }
      let(:result) { ccs_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with default width navigation (one column)'" do
      let(:fixture_name) { 'with default width navigation (one column)' }
      let(:result) { ccs_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with default width navigation (two columns)'" do
      let(:fixture_name) { 'with default width navigation (two columns)' }
      let(:result) { ccs_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with navigation'" do
      let(:fixture_name) { 'with navigation' }
      let(:result) { ccs_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'Full CCS example'" do
      let(:fixture_name) { 'Full CCS example' }
      let(:result) { ccs_footer(navigation: fixture_options[:navigation], meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with three equal columns'" do
      let(:fixture_name) { 'with three equal columns' }
      let(:result) { ccs_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { ccs_footer(attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { ccs_footer(classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with container classes'" do
      let(:fixture_name) { 'with container classes' }
      let(:result) { ccs_footer(container_classes: fixture_options[:containerClasses]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with empty meta'" do
      let(:fixture_name) { 'with empty meta' }
      let(:result) { ccs_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with empty meta items'" do
      let(:fixture_name) { 'with empty meta items' }
      let(:result) { ccs_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'meta html as text'" do
      let(:fixture_name) { 'meta html as text' }
      let(:result) { ccs_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with meta html'" do
      let(:fixture_name) { 'with meta html' }
      let(:result) { ccs_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with meta item attributes'" do
      let(:fixture_name) { 'with meta item attributes' }
      let(:result) { ccs_footer(meta: fixture_options[:meta]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with empty navigation'" do
      let(:fixture_name) { 'with empty navigation' }
      let(:result) { ccs_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with navigation item attributes'" do
      let(:fixture_name) { 'with navigation item attributes' }
      let(:result) { ccs_footer(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
