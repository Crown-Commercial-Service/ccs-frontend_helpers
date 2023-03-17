# frozen_string_literal: true

require 'ccs/components/govuk/fieldset'

RSpec.describe CCS::Components::GovUK::Fieldset do
  include_context 'and I have a view context'

  let(:fieldset_group_element) { Capybara::Node::Simple.new(result).find('fieldset.govuk-fieldset') }

  describe '.render' do
    let(:govuk_fieldset) { described_class.new(context: view_context, **options) }
    let(:result) do
      govuk_fieldset.render do
        view_context.concat(tag.label('Agnus heros', for: 'agnus-heros'))
        view_context.concat(tag.input(id: 'agnus-heros'))
        view_context.concat(tag.label('Keves heros', for: 'keves-heros'))
        view_context.concat(tag.input(id: 'keves-heros'))
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
      let(:govuk_fieldset) { described_class.new(context: view_context) }

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
  end
end
