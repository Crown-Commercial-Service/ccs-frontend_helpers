# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/details'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Details, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_details from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'details' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) do
        govuk_details(fixture_options[:summaryText]) do
          fixture_options[:text]
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'expanded'" do
      let(:fixture_name) { 'expanded' }
      let(:result) do
        govuk_details(fixture_options[:summaryText], attributes: { id: fixture_options[:id], open: fixture_options[:open] }) do
          fixture_options[:text]
        end
      end

      it 'has HTML matching the fixture' do
        # We need to update the open attribute in the fixture as rails will render the single attributes as equaling themself
        expect(result).to eq_html(fixture_html.gsub('open>', 'open="open">'))
      end
    end

    context "when the fixture is 'with html'" do
      let(:fixture_name) { 'with html' }
      let(:result) do
        govuk_details(fixture_options[:summaryText]) do
          fixture_options[:html].html_safe
        end.to_one_line
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) do
        govuk_details(fixture_options[:summaryText], attributes: { id: fixture_options[:id] }) do
          fixture_options[:text]
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) do
        govuk_details(fixture_options[:summaryText]) do
          fixture_options[:text]
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) do
        govuk_details(fixture_options[:summaryText]) do
          fixture_options[:html].html_safe
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'summary html as text'" do
      let(:fixture_name) { 'summary html as text' }
      let(:result) do
        govuk_details(fixture_options[:summaryText]) do
          fixture_options[:text]
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'summary html'" do
      let(:fixture_name) { 'summary html' }
      let(:result) do
        govuk_details(fixture_options[:summaryHtml].html_safe) do
          fixture_options[:text]
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) do
        govuk_details(fixture_options[:summaryText], classes: fixture_options[:classes]) do
          fixture_options[:text]
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) do
        govuk_details(fixture_options[:summaryText], attributes: fixture_options[:attributes]) do
          fixture_options[:text]
        end
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
