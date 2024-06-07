# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/tag'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Tag, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_tag from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'tag' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_tag(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'grey'" do
      let(:fixture_name) { 'grey' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'blue'" do
      let(:fixture_name) { 'blue' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'light blue'" do
      let(:fixture_name) { 'light blue' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name.gsub(' ', '-')) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'turquoise'" do
      let(:fixture_name) { 'turquoise' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'green'" do
      let(:fixture_name) { 'green' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'purple'" do
      let(:fixture_name) { 'purple' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'pink'" do
      let(:fixture_name) { 'pink' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'red'" do
      let(:fixture_name) { 'red' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'orange'" do
      let(:fixture_name) { 'orange' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'yellow'" do
      let(:fixture_name) { 'yellow' }
      let(:result) { govuk_tag(fixture_options[:text], fixture_name) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_tag(fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_tag(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_tag(fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
