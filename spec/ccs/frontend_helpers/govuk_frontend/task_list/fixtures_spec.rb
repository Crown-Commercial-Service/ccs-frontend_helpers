# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/task_list'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::TaskList, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_task_list from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'task-list' }

    before do
      fixture_options[:items].each do |item|
        next if item.blank?

        %i[title hint status].each do |attribute|
          if item.dig(attribute, :html)
            item[attribute][:text] = item[attribute][:html].html_safe
            item[attribute].delete(:html)
          end
        end
        if item[:href]
          item[:title][:href] = item[:href]
          item.delete(:href)
        end
        if item[:status][:tag]
          if item[:status][:tag][:html]
            item[:status][:tag][:text] = item[:status][:tag][:html].html_safe
            item[:status][:tag].delete(:html)
          end
          item[:status][:tag_options] = item[:status][:tag]
          item[:status].delete(:tag)
        end
        if item[:hint]
          item[:hint_text] = item[:hint][:text]
          item.delete(:hint)
        end
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_task_list(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'example with 3 states'" do
      let(:fixture_name) { 'example with 3 states' }
      let(:result) { govuk_task_list(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'example with hint text and additional states'" do
      let(:fixture_name) { 'example with hint text and additional states' }
      let(:result) { govuk_task_list(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'example with all possible colours'" do
      let(:fixture_name) { 'example with all possible colours' }
      let(:result) { govuk_task_list(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'example with very long single word tags'" do
      let(:fixture_name) { 'example with very long single word tags' }
      let(:result) { govuk_task_list(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom classes'" do
      let(:fixture_name) { 'custom classes' }
      let(:result) { govuk_task_list(fixture_options[:items], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('govuk-task-list__item govuk-task-list__item--with-link custom-class-on-task', 'govuk-task-list__item custom-class-on-task govuk-task-list__item--with-link'))
      end
    end

    context "when the fixture is 'custom attributes'" do
      let(:fixture_name) { 'custom attributes' }
      let(:result) { govuk_task_list(fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom id prefix'" do
      let(:fixture_name) { 'custom id prefix' }
      let(:result) { govuk_task_list(fixture_options[:items], id_prefix: fixture_options[:idPrefix]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html passed as text'" do
      let(:fixture_name) { 'html passed as text' }
      let(:result) { govuk_task_list(fixture_options[:items], id_prefix: fixture_options[:idPrefix]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_task_list(fixture_options[:items], id_prefix: fixture_options[:idPrefix]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with empty values'" do
      let(:fixture_name) { 'with empty values' }
      let(:result) { govuk_task_list(fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
