# frozen_string_literal: true

require 'ccs/components/govuk/fieldset/legend'

RSpec.describe CCS::Components::GovUK::Fieldset::Legend do
  include_context 'and I have a view context'

  let(:fieldset_legend_element) { Capybara::Node::Simple.new(result).find('legend.govuk-fieldset__legend') }

  describe '.render' do
    let(:govuk_fieldset_legend) { described_class.new(text: text, is_page_heading: is_page_heading, caption: caption, context: view_context, **options) }
    let(:result) { govuk_fieldset_legend.render }

    let(:text) { 'What heros are your favourite?' }
    let(:is_page_heading) { nil }
    let(:caption) { nil }
    let(:options) { {} }

    let(:default_html) do
      '
        <legend class="govuk-fieldset__legend">
          What heros are your favourite?
        </legend>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the legend' do
        expect(fieldset_legend_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_fieldset_legend) { described_class.new(text: text, is_page_heading: is_page_heading, caption: caption, context: view_context) }

      it 'correctly formats the HTML with the legend' do
        expect(fieldset_legend_element.to_html).to eq(default_html)
      end
    end

    context 'when the no optional attributes are sent' do
      let(:govuk_fieldset_legend) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the legend' do
        expect(fieldset_legend_element.to_html).to eq(default_html)
      end
    end

    context 'when the legend is a heading' do
      let(:is_page_heading) { true }

      it 'has legend within the h1' do
        expect(fieldset_legend_element).to have_css('h1.govuk-fieldset__heading')
      end

      context 'and it has a caption' do
        let(:caption) { { text: 'Select a hero', classes: 'govuk-caption-m' } }

        it 'the legend has a caption above the h1' do
          expect(fieldset_legend_element).to have_css('span.govuk-caption-m', text: 'Select a hero')
          expect(fieldset_legend_element).to have_css('h1.govuk-fieldset__heading', text: 'What heros are your favourite?')
        end
      end
    end

    context 'when the legend has additional classes' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'correctly formats the HTML with the legend and its additional classes' do
        expect(fieldset_legend_element[:class]).to eq 'govuk-fieldset__legend my-custom-class'
      end
    end
  end
end
