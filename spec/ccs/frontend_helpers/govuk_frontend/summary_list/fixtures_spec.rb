# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/summary_list'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::SummaryList, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_summary_list from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'summary-list' }

    before do
      fixture_options[:rows].each do |row|
        %i[key value].each do |attribute|
          if row[attribute][:html]
            row[attribute][:text] = row[attribute][:html].html_safe
            row[attribute].delete(:html)
          end
        end
        row.dig(:actions, :items)&.each do |item|
          if item[:visuallyHiddenText]
            item[:visually_hidden_text] = item[:visuallyHiddenText]
            item.delete(:visuallyHiddenText)
          end
          if item[:html]
            item[:text] = item[:html].html_safe
            item.delete(:html)
          end
        end
      end

      if fixture_options[:card]
        if fixture_options[:card].dig(:title, :headingLevel)
          fixture_options[:card][:title][:heading_level] = fixture_options[:card][:title][:headingLevel]
          fixture_options[:card][:title].delete(:headingLevel)
        end
        if fixture_options[:card].dig(:title, :html)
          fixture_options[:card][:title][:text] = fixture_options[:card][:title][:html].html_safe
          fixture_options[:card][:title].delete(:html)
        end
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with actions'" do
      let(:fixture_name) { 'with actions' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'translated'" do
      let(:fixture_name) { 'translated' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with some actions'" do
      let(:fixture_name) { 'with some actions' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with no first action'" do
      let(:fixture_name) { 'with no first action' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'no-border'" do
      let(:fixture_name) { 'no-border' }
      let(:result) { govuk_summary_list(fixture_options[:rows], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'no-border on last row'" do
      let(:fixture_name) { 'no-border on last row' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'overridden-widths'" do
      let(:fixture_name) { 'overridden-widths' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'check-your-answers'" do
      let(:fixture_name) { 'check-your-answers' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'extreme'" do
      let(:fixture_name) { 'extreme' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as a summary card with a text header'" do
      let(:fixture_name) { 'as a summary card with a text header' }
      let(:result) { govuk_summary_list(fixture_options[:rows], card: fixture_options[:card]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as a summary card with a custom header level'" do
      let(:fixture_name) { 'as a summary card with a custom header level' }
      let(:result) { govuk_summary_list(fixture_options[:rows], card: fixture_options[:card]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as a summary card with a html header'" do
      let(:fixture_name) { 'as a summary card with a html header' }
      let(:result) { govuk_summary_list(fixture_options[:rows], card: fixture_options[:card]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as a summary card with actions'" do
      let(:fixture_name) { 'as a summary card with actions' }
      let(:result) { govuk_summary_list(fixture_options[:rows], card: fixture_options[:card]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'as a summary card with actions plus summary list actions'" do
      let(:fixture_name) { 'as a summary card with actions plus summary list actions' }
      let(:result) { govuk_summary_list(fixture_options[:rows], card: fixture_options[:card]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_summary_list(fixture_options[:rows], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'key with html'" do
      let(:fixture_name) { 'key with html' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'key with classes'" do
      let(:fixture_name) { 'key with classes' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'value with html'" do
      let(:fixture_name) { 'value with html' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'actions href'" do
      let(:fixture_name) { 'actions href' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'actions with html'" do
      let(:fixture_name) { 'actions with html' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'actions with classes'" do
      let(:fixture_name) { 'actions with classes' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'actions with attributes'" do
      let(:fixture_name) { 'actions with attributes' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'single action with anchor'" do
      let(:fixture_name) { 'single action with anchor' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes on items'" do
      let(:fixture_name) { 'classes on items' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'empty items array'" do
      let(:fixture_name) { 'empty items array' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'rows with classes'" do
      let(:fixture_name) { 'rows with classes' }
      let(:result) { govuk_summary_list(fixture_options[:rows]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'summary card with custom classes'" do
      let(:fixture_name) { 'summary card with custom classes' }
      let(:result) { govuk_summary_list(fixture_options[:rows], card: fixture_options[:card]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'summary card with custom attributes'" do
      let(:fixture_name) { 'summary card with custom attributes' }
      let(:result) { govuk_summary_list(fixture_options[:rows], card: fixture_options[:card]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'summary card with only 1 action'" do
      let(:fixture_name) { 'summary card with only 1 action' }
      let(:result) { govuk_summary_list(fixture_options[:rows], card: fixture_options[:card]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
