# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/fieldset'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Fieldset, type: :helper do
  include described_class

  let(:fieldset_group_element) { Capybara::Node::Simple.new(result).find('fieldset.govuk-fieldset') }

  describe '.govuk_fieldset' do
    let(:result) do
      govuk_fieldset(**options) do
        concat(tag.label('Agnus heros', for: 'agnus-heros'))
        concat(tag.input(id: 'agnus-heros'))
        concat(tag.label('Keves heros', for: 'keves-heros'))
        concat(tag.input(id: 'keves-heros'))
      end
    end

    let(:options) { { legend: { text: 'What heros are your favourite?' } } }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the legend and content' do
        expect(fieldset_group_element.to_html).to eq('
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              What heros are your favourite?
            </legend>
            <label for="agnus-heros">Agnus heros</label>
            <input id="agnus-heros">
            <label for="keves-heros">Keves heros</label>
            <input id="keves-heros">
          </fieldset>
        '.to_one_line)
      end
    end

    context 'when the no options are sent' do
      let(:result) do
        govuk_fieldset do
          concat(tag.label('Agnus heros', for: 'agnus-heros'))
          concat(tag.input(id: 'agnus-heros'))
          concat(tag.label('Keves heros', for: 'keves-heros'))
          concat(tag.input(id: 'keves-heros'))
        end
      end

      it 'correctly formats the HTML without a legend and but with the content' do
        expect(fieldset_group_element.to_html).to eq('
          <fieldset class="govuk-fieldset">
            <label for="agnus-heros">Agnus heros</label>
            <input id="agnus-heros">
            <label for="keves-heros">Keves heros</label>
            <input id="keves-heros">
          </fieldset>
        '.to_one_line)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { super().merge({ classes: 'my-custom-class' }) }

      it 'has the custom class' do
        expect(fieldset_group_element[:class]).to eq('govuk-fieldset my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { super().merge({ attributes: { aria: { describedby: 'some-id' }, role: 'group' } }) }

      it 'has the additional attributes' do
        expect(fieldset_group_element[:'aria-describedby']).to eq('some-id')
        expect(fieldset_group_element[:role]).to eq('group')
      end
    end

    context 'when the legend is a heading' do
      let(:options) { { legend: { is_page_heading: true, text: 'What heros are your favourite?' } } }

      it 'has legend within the h1' do
        expect(fieldset_group_element).to have_css('legend.govuk-fieldset__legend > h1.govuk-fieldset__heading')
      end

      context 'and it has a caption' do
        let(:options) { { legend: { is_page_heading: true, text: 'What heros are your favourite?', caption: { text: 'Select a hero', classes: 'govuk-caption-m' } } } }

        it 'the legend has a caption above the h1' do
          expect(fieldset_group_element).to have_css('legend.govuk-fieldset__legend > span.govuk-caption-m', text: 'Select a hero')
          expect(fieldset_group_element).to have_css('legend.govuk-fieldset__legend > h1.govuk-fieldset__heading', text: 'What heros are your favourite?')
        end
      end
    end

    context 'when the legend has additional classes' do
      let(:options) { { legend: { text: 'What heros are your favourite?', classes: 'my-custom-class' } } }

      it 'correctly formats the HTML with the legend and its additional classes' do
        expect(fieldset_group_element.find('legend')[:class]).to eq 'govuk-fieldset__legend my-custom-class'
      end
    end
  end
end
