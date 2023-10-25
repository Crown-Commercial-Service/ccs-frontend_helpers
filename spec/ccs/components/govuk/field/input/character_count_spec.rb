# frozen_string_literal: true

require 'ccs/components/govuk/field/input/character_count'

RSpec.describe CCS::Components::GovUK::Field::Input::CharacterCount do
  include_context 'and I have a view context'

  let(:character_count_element) { Capybara::Node::Simple.new(result).find('div.govuk-character-count') }
  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:label_element) { Capybara::Node::Simple.new(result).find('label.govuk-label') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group > div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:textarea_element) { Capybara::Node::Simple.new(result).find('textarea.govuk-textarea') }
  let(:fallback_hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-character-count__message') }

  let(:result) { govuk_character_count.render }

  let(:attribute) { 'ouroboros' }
  let(:options) do
    {
      form_group: form_group_options,
      label: {
        text: 'Explain why they are your favourite character'
      }.merge(label_options),
    }.merge(textarea_options)
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Explain why they are your favourite character'
      }.merge(label_options),
    }
  end
  let(:options_with_hint) do
    {
      form_group: form_group_options,
      label: {
        text: 'Explain why they are your favourite character'
      }.merge(label_options),
      hint: {
        text: 'For example, is it their combat, or their style?'
      }.merge(hint_options),
    }.merge(textarea_options)
  end
  let(:form_group_options) { {} }
  let(:label_options) { {} }
  let(:hint_options) { {} }
  let(:textarea_options) { {} }
  let(:character_count_options) { { maxlength: 200 } }
  let(:test_model) { TestModel.new }

  describe '.render' do
    let(:govuk_character_count) { described_class.new(attribute: attribute, character_count_options: character_count_options, error_message: error_message, context: view_context, **options) }

    let(:error_message) { nil }

    let(:default_html) do
      '
        <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Explain why they are your favourite character
            </label>
            <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info" class="govuk-textarea govuk-js-character-count" rows="5">
            </textarea>
          </div>
          <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
            You can enter up to 200 characters
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_character_count) { described_class.new(attribute: attribute, character_count_options: character_count_options, context: view_context, **options) }

      let(:options) { minimum_options }

      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when max words is provided for the character count options' do
      let(:character_count_options) { { maxwords: 150 } }

      it 'has the max words data attribute and the text for the fallback hint is updated' do
        expect(character_count_element[:'data-maxwords']).to eq('150')
        expect(fallback_hint_element).to have_content('You can enter up to 150 words')
      end
    end

    context 'when max words is provided along with maxlength for the character count options' do
      let(:character_count_options) { super().merge({ maxwords: 150 }) }

      it 'has the max length and words data attribute but the fallback hint uses max words' do
        expect(character_count_element[:'data-maxlength']).to eq('200')
        expect(character_count_element[:'data-maxwords']).to eq('150')
        expect(fallback_hint_element).to have_content('You can enter up to 150 words')
      end
    end

    context 'when threshold is provided for the character count options' do
      let(:character_count_options) { super().merge({ threshold: 150 }) }

      it 'has the threshold data attribute as well as max length' do
        expect(character_count_element[:'data-maxlength']).to eq('200')
        expect(character_count_element[:'data-threshold']).to eq('150')
      end
    end

    context 'when there is a fallback hint' do
      let(:character_count_options) { super().merge({ fallback_hint: { count_message: 'Enter no more than %<count>s characters' } }) }

      it 'uses the custom fallback hint message' do
        expect(fallback_hint_element).to have_content('Enter no more than 200 characters')
      end

      context 'and there are additional classes' do
        let(:character_count_options) { super().merge({ fallback_hint: { count_message: 'Enter no more than %<count>s characters', classes: 'extra-fallback-hint-class' } }) }

        it 'has the custom classes for the fallback hint' do
          expect(fallback_hint_element).to have_content('Enter no more than 200 characters')
          expect(fallback_hint_element[:class]).to eq('govuk-hint extra-fallback-hint-class govuk-character-count__message')
        end
      end
    end

    context 'when considering the other options used for the text area' do
      context 'when additional classes are passed' do
        let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
        let(:label_options) { { classes: 'my-custom-label-class' } }
        let(:textarea_options) { { classes: 'my-custom-textarea-class' } }

        it 'has the custom classes' do
          expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
          expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
          expect(textarea_element[:class]).to eq('govuk-textarea my-custom-textarea-class govuk-js-character-count')
        end
      end

      context 'when additional ids are passed' do
        let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
        let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
        let(:textarea_options) { { attributes: { id: 'my-custom-textarea-id' } } }

        it 'has the custom ids' do
          expect(form_group_element[:id]).to eq('my-custom-form-group-id')
          expect(label_element[:id]).to eq('my-custom-label-id')
          expect(textarea_element[:id]).to eq('my-custom-textarea-id')
        end
      end

      context 'when content is passed' do
        let(:textarea_options) { { content: 'Come on, who else?' } }

        it 'has the content in the text area' do
          expect(textarea_element).to have_content('Come on, who else?')
        end
      end

      context 'when a custom name is passed' do
        let(:textarea_options) { { attributes: { name: 'my-custom-name' } } }

        it 'has the custom name in the textarea' do
          expect(textarea_element[:name]).to eq('my-custom-name')
        end
      end

      context 'when a custom rows is passed' do
        let(:textarea_options) { { rows: '10' } }

        it 'has the the custom number of rows' do
          expect(textarea_element[:rows]).to eq('10')
        end
      end

      context 'when custom attributes are passed' do
        let(:textarea_options) { { attributes: { pattern: '[0-9]*', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

        it 'has the additional attributes for the text area' do
          expect(textarea_element[:pattern]).to eq('[0-9]*')
          expect(textarea_element[:'aria-describedby']).to eq('some-id ouroboros-info')
          expect(textarea_element[:'data-test']).to eq('my data value')
        end
      end

      context 'when there is a hint' do
        let(:options) { options_with_hint }

        context 'when the default attributes are sent' do
          it 'correctly formats the HTML with the hint' do
            expect(character_count_element.to_html).to eq('
              <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
                <div class="govuk-form-group" id="ouroboros-form-group">
                  <label class="govuk-label" for="ouroboros">
                    Explain why they are your favourite character
                  </label>
                  <div id="ouroboros-hint" class="govuk-hint">
                    For example, is it their combat, or their style?
                  </div>
                  <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-hint" class="govuk-textarea govuk-js-character-count" rows="5">
                  </textarea>
                </div>
                <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                  You can enter up to 200 characters
                </div>
              </div>
            '.to_one_line)
          end
        end

        context 'when additional classes are passed' do
          let(:hint_options) { { classes: 'my-custom-hint-class' } }

          it 'has the custom classes for the hint' do
            expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
          end
        end

        context 'when additional ids are passed' do
          let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

          it 'has the custom id for the hint and the text area has it in its area describedby' do
            expect(hint_element[:id]).to eq('my-custom-hint-id')
            expect(textarea_element[:'aria-describedby']).to eq('ouroboros-info my-custom-hint-id')
          end
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom and hint id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id ouroboros-info ouroboros-hint')
          end
        end
      end

      context 'when there is an error message' do
        let(:error_message) { 'You must enter your favourite character' }

        it 'correctly formats the HTML with error message and classes' do
          expect(character_count_element.to_html).to eq('
            <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
              <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
                <label class="govuk-label" for="ouroboros">
                  Explain why they are your favourite character
                </label>
                <p class="govuk-error-message" id="ouroboros-error">
                  <span class="govuk-visually-hidden">Error: </span>
                  You must enter your favourite character
                </p>
                <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-error" class="govuk-textarea govuk-js-character-count govuk-textarea--error" rows="5">
                </textarea>
              </div>
              <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                You can enter up to 200 characters
              </div>
            </div>
          '.to_one_line)
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom and error id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id ouroboros-info ouroboros-error')
          end
        end
      end

      context 'when there is a hint and an error message' do
        let(:error_message) { 'You must enter your favourite character' }
        let(:options) { options_with_hint }

        it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
          expect(character_count_element.to_html).to eq('
            <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
              <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
                <label class="govuk-label" for="ouroboros">
                  Explain why they are your favourite character
                </label>
                <div id="ouroboros-hint" class="govuk-hint">
                  For example, is it their combat, or their style?
                </div>
                <p class="govuk-error-message" id="ouroboros-error">
                  <span class="govuk-visually-hidden">Error: </span>
                  You must enter your favourite character
                </p>
                <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-hint ouroboros-error" class="govuk-textarea govuk-js-character-count govuk-textarea--error" rows="5">
                </textarea>
              </div>
              <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                You can enter up to 200 characters
              </div>
            </div>
          '.to_one_line)
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom, hint and error id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id ouroboros-info ouroboros-hint ouroboros-error')
          end
        end
      end
    end
  end

  describe '.render with model' do
    let(:govuk_character_count) { described_class.new(attribute: attribute, character_count_options: character_count_options, model: test_model, context: view_context, **options) }

    let(:default_html) do
      '
        <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Explain why they are your favourite character
            </label>
            <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info" class="govuk-textarea govuk-js-character-count" rows="5">
            </textarea>
          </div>
          <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
            You can enter up to 200 characters
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:options) { minimum_options }

      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when max words is provided for the character count options' do
      let(:character_count_options) { { maxwords: 150 } }

      it 'has the max words data attribute and the text for the fallback hint is updated' do
        expect(character_count_element[:'data-maxwords']).to eq('150')
        expect(fallback_hint_element).to have_content('You can enter up to 150 words')
      end
    end

    context 'when max words is provided along with maxlength for the character count options' do
      let(:character_count_options) { super().merge({ maxwords: 150 }) }

      it 'has the max length and words data attribute but the fallback hint uses max words' do
        expect(character_count_element[:'data-maxlength']).to eq('200')
        expect(character_count_element[:'data-maxwords']).to eq('150')
        expect(fallback_hint_element).to have_content('You can enter up to 150 words')
      end
    end

    context 'when threshold is provided for the character count options' do
      let(:character_count_options) { super().merge({ threshold: 150 }) }

      it 'has the threshold data attribute as well as max length' do
        expect(character_count_element[:'data-maxlength']).to eq('200')
        expect(character_count_element[:'data-threshold']).to eq('150')
      end
    end

    context 'when there is a fallback hint' do
      let(:character_count_options) { super().merge({ fallback_hint: { count_message: 'Enter no more than %<count>s characters' } }) }

      it 'uses the custom fallback hint message' do
        expect(fallback_hint_element).to have_content('Enter no more than 200 characters')
      end

      context 'and there are additional classes' do
        let(:character_count_options) { super().merge({ fallback_hint: { count_message: 'Enter no more than %<count>s characters', classes: 'extra-fallback-hint-class' } }) }

        it 'has the custom classes for the fallback hint' do
          expect(fallback_hint_element).to have_content('Enter no more than 200 characters')
          expect(fallback_hint_element[:class]).to eq('govuk-hint extra-fallback-hint-class govuk-character-count__message')
        end
      end
    end

    context 'when considering the other options used for the text area' do
      context 'and the model has a value' do
        before { test_model.ouroboros = 'Come on, who else?' }

        it 'has the content in the text area' do
          expect(textarea_element).to have_content('Come on, who else?')
        end
      end

      context 'when additional classes are passed' do
        let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
        let(:label_options) { { classes: 'my-custom-label-class' } }
        let(:textarea_options) { { classes: 'my-custom-textarea-class' } }

        it 'has the custom classes' do
          expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
          expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
          expect(textarea_element[:class]).to eq('govuk-textarea my-custom-textarea-class govuk-js-character-count')
        end
      end

      context 'when additional ids are passed' do
        let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
        let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
        let(:textarea_options) { { attributes: { id: 'my-custom-textarea-id' } } }

        it 'has the custom ids' do
          expect(form_group_element[:id]).to eq('my-custom-form-group-id')
          expect(label_element[:id]).to eq('my-custom-label-id')
          expect(textarea_element[:id]).to eq('my-custom-textarea-id')
        end
      end

      context 'when a custom name is passed' do
        let(:textarea_options) { { attributes: { name: 'my-custom-name' } } }

        it 'has the custom name in the textarea' do
          expect(textarea_element[:name]).to eq('my-custom-name')
        end
      end

      context 'when a custom rows is passed' do
        let(:textarea_options) { { rows: '10' } }

        it 'has the the custom number of rows' do
          expect(textarea_element[:rows]).to eq('10')
        end
      end

      context 'when custom attributes are passed' do
        let(:textarea_options) { { attributes: { pattern: '[0-9]*', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

        it 'has the additional attributes for the text area' do
          expect(textarea_element[:pattern]).to eq('[0-9]*')
          expect(textarea_element[:'aria-describedby']).to eq('some-id ouroboros-info')
          expect(textarea_element[:'data-test']).to eq('my data value')
        end
      end

      context 'when there is a hint' do
        let(:options) { options_with_hint }

        context 'when the default attributes are sent' do
          it 'correctly formats the HTML with the hint' do
            expect(character_count_element.to_html).to eq('
              <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
                <div class="govuk-form-group" id="ouroboros-form-group">
                  <label class="govuk-label" for="ouroboros">
                    Explain why they are your favourite character
                  </label>
                  <div id="ouroboros-hint" class="govuk-hint">
                    For example, is it their combat, or their style?
                  </div>
                  <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-hint" class="govuk-textarea govuk-js-character-count" rows="5">
                  </textarea>
                </div>
                <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                  You can enter up to 200 characters
                </div>
              </div>
            '.to_one_line)
          end
        end

        context 'when additional classes are passed' do
          let(:hint_options) { { classes: 'my-custom-hint-class' } }

          it 'has the custom classes for the hint' do
            expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
          end
        end

        context 'when additional ids are passed' do
          let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

          it 'has the custom id for the hint and the text area has it in its area describedby' do
            expect(hint_element[:id]).to eq('my-custom-hint-id')
            expect(textarea_element[:'aria-describedby']).to eq('ouroboros-info my-custom-hint-id')
          end
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom and hint id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id ouroboros-info ouroboros-hint')
          end
        end
      end

      context 'when there is an error message' do
        before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

        it 'correctly formats the HTML with error message and classes' do
          expect(character_count_element.to_html).to eq('
            <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
              <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
                <label class="govuk-label" for="ouroboros">
                  Explain why they are your favourite character
                </label>
                <p class="govuk-error-message" id="ouroboros-error">
                  <span class="govuk-visually-hidden">Error: </span>
                  You must enter your favourite character
                </p>
                <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-error" class="govuk-textarea govuk-js-character-count govuk-textarea--error" rows="5">
                </textarea>
              </div>
              <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                You can enter up to 200 characters
              </div>
            </div>
          '.to_one_line)
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom and error id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id ouroboros-info ouroboros-error')
          end
        end
      end

      context 'when there is a hint and an error message' do
        let(:options) { options_with_hint }

        before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

        it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
          expect(character_count_element.to_html).to eq('
            <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
              <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
                <label class="govuk-label" for="ouroboros">
                  Explain why they are your favourite character
                </label>
                <div id="ouroboros-hint" class="govuk-hint">
                  For example, is it their combat, or their style?
                </div>
                <p class="govuk-error-message" id="ouroboros-error">
                  <span class="govuk-visually-hidden">Error: </span>
                  You must enter your favourite character
                </p>
                <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-hint ouroboros-error" class="govuk-textarea govuk-js-character-count govuk-textarea--error" rows="5">
                </textarea>
              </div>
              <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                You can enter up to 200 characters
              </div>
            </div>
          '.to_one_line)
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom, hint and error id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id ouroboros-info ouroboros-hint ouroboros-error')
          end
        end
      end
    end
  end

  describe '.render with form' do
    include_context 'and I have a form from a model'

    let(:govuk_character_count) { described_class.new(attribute: attribute, character_count_options: character_count_options, form: form, context: view_context, **options) }

    let(:default_html) do
      '
        <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Explain why they are your favourite character
            </label>
            <textarea aria-describedby="test_model_ouroboros-info" class="govuk-textarea govuk-js-character-count" rows="5" name="test_model[ouroboros]" id="test_model_ouroboros">
            </textarea>
          </div>
          <div id="test_model_ouroboros-info" class="govuk-hint govuk-character-count__message">
            You can enter up to 200 characters
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:options) { minimum_options }

      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when max words is provided for the character count options' do
      let(:character_count_options) { { maxwords: 150 } }

      it 'has the max words data attribute and the text for the fallback hint is updated' do
        expect(character_count_element[:'data-maxwords']).to eq('150')
        expect(fallback_hint_element).to have_content('You can enter up to 150 words')
      end
    end

    context 'when max words is provided along with maxlength for the character count options' do
      let(:character_count_options) { super().merge({ maxwords: 150 }) }

      it 'has the max length and words data attribute but the fallback hint uses max words' do
        expect(character_count_element[:'data-maxlength']).to eq('200')
        expect(character_count_element[:'data-maxwords']).to eq('150')
        expect(fallback_hint_element).to have_content('You can enter up to 150 words')
      end
    end

    context 'when threshold is provided for the character count options' do
      let(:character_count_options) { super().merge({ threshold: 150 }) }

      it 'has the threshold data attribute as well as max length' do
        expect(character_count_element[:'data-maxlength']).to eq('200')
        expect(character_count_element[:'data-threshold']).to eq('150')
      end
    end

    context 'when there is a fallback hint' do
      let(:character_count_options) { super().merge({ fallback_hint: { count_message: 'Enter no more than %<count>s characters' } }) }

      it 'uses the custom fallback hint message' do
        expect(fallback_hint_element).to have_content('Enter no more than 200 characters')
      end

      context 'and there are additional classes' do
        let(:character_count_options) { super().merge({ fallback_hint: { count_message: 'Enter no more than %<count>s characters', classes: 'extra-fallback-hint-class' } }) }

        it 'has the custom classes for the fallback hint' do
          expect(fallback_hint_element).to have_content('Enter no more than 200 characters')
          expect(fallback_hint_element[:class]).to eq('govuk-hint extra-fallback-hint-class govuk-character-count__message')
        end
      end
    end

    context 'when considering the other options used for the text area' do
      context 'and the model has a value' do
        before { test_model.ouroboros = 'Come on, who else?' }

        it 'has the content in the text area' do
          expect(textarea_element).to have_content('Come on, who else?')
        end
      end

      context 'when additional classes are passed' do
        let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
        let(:label_options) { { classes: 'my-custom-label-class' } }
        let(:textarea_options) { { classes: 'my-custom-textarea-class' } }

        it 'has the custom classes' do
          expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
          expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
          expect(textarea_element[:class]).to eq('govuk-textarea my-custom-textarea-class govuk-js-character-count')
        end
      end

      context 'when additional ids are passed' do
        let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
        let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
        let(:textarea_options) { { attributes: { id: 'my-custom-textarea-id' } } }

        it 'has the custom ids' do
          expect(form_group_element[:id]).to eq('my-custom-form-group-id')
          expect(label_element[:id]).to eq('my-custom-label-id')
          expect(textarea_element[:id]).to eq('my-custom-textarea-id')
        end
      end

      context 'when a custom name is passed' do
        let(:textarea_options) { { attributes: { name: 'my-custom-name' } } }

        it 'has the custom name in the textarea' do
          expect(textarea_element[:name]).to eq('my-custom-name')
        end
      end

      context 'when a custom rows is passed' do
        let(:textarea_options) { { rows: '10' } }

        it 'has the the custom number of rows' do
          expect(textarea_element[:rows]).to eq('10')
        end
      end

      context 'when custom attributes are passed' do
        let(:textarea_options) { { attributes: { pattern: '[0-9]*', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

        it 'has the additional attributes for the text area' do
          expect(textarea_element[:pattern]).to eq('[0-9]*')
          expect(textarea_element[:'aria-describedby']).to eq('some-id test_model_ouroboros-info')
          expect(textarea_element[:'data-test']).to eq('my data value')
        end
      end

      context 'when there is a hint' do
        let(:options) { options_with_hint }

        context 'when the default attributes are sent' do
          it 'correctly formats the HTML with the hint' do
            expect(character_count_element.to_html).to eq('
              <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
                <div class="govuk-form-group" id="ouroboros-form-group">
                  <label class="govuk-label" for="test_model_ouroboros">
                    Explain why they are your favourite character
                  </label>
                  <div id="ouroboros-hint" class="govuk-hint">
                    For example, is it their combat, or their style?
                  </div>
                  <textarea aria-describedby="test_model_ouroboros-info ouroboros-hint" class="govuk-textarea govuk-js-character-count" rows="5" name="test_model[ouroboros]" id="test_model_ouroboros">
                  </textarea>
                </div>
                <div id="test_model_ouroboros-info" class="govuk-hint govuk-character-count__message">
                  You can enter up to 200 characters
                </div>
              </div>
            '.to_one_line)
          end
        end

        context 'when additional classes are passed' do
          let(:hint_options) { { classes: 'my-custom-hint-class' } }

          it 'has the custom classes for the hint' do
            expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
          end
        end

        context 'when additional ids are passed' do
          let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

          it 'has the custom id for the hint and the text area has it in its area describedby' do
            expect(hint_element[:id]).to eq('my-custom-hint-id')
            expect(textarea_element[:'aria-describedby']).to eq('test_model_ouroboros-info my-custom-hint-id')
          end
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom and hint id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id test_model_ouroboros-info ouroboros-hint')
          end
        end
      end

      context 'when there is an error message' do
        before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

        it 'correctly formats the HTML with error message and classes' do
          expect(character_count_element.to_html).to eq('
            <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
              <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
                <label class="govuk-label" for="test_model_ouroboros">
                  Explain why they are your favourite character
                </label>
                <p class="govuk-error-message" id="ouroboros-error">
                  <span class="govuk-visually-hidden">Error: </span>
                  You must enter your favourite character
                </p>
                <textarea aria-describedby="test_model_ouroboros-info ouroboros-error" class="govuk-textarea govuk-js-character-count govuk-textarea--error" rows="5" name="test_model[ouroboros]" id="test_model_ouroboros">
                </textarea>
              </div>
              <div id="test_model_ouroboros-info" class="govuk-hint govuk-character-count__message">
                You can enter up to 200 characters
              </div>
            </div>
          '.to_one_line)
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom and error id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id test_model_ouroboros-info ouroboros-error')
          end
        end
      end

      context 'when there is a hint and an error message' do
        let(:options) { options_with_hint }

        before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

        it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
          expect(character_count_element.to_html).to eq('
            <div class="govuk-character-count" data-module="govuk-character-count" data-maxlength="200">
              <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
                <label class="govuk-label" for="test_model_ouroboros">
                  Explain why they are your favourite character
                </label>
                <div id="ouroboros-hint" class="govuk-hint">
                  For example, is it their combat, or their style?
                </div>
                <p class="govuk-error-message" id="ouroboros-error">
                  <span class="govuk-visually-hidden">Error: </span>
                  You must enter your favourite character
                </p>
                <textarea aria-describedby="test_model_ouroboros-info ouroboros-hint ouroboros-error" class="govuk-textarea govuk-js-character-count govuk-textarea--error" rows="5" name="test_model[ouroboros]" id="test_model_ouroboros">
                </textarea>
              </div>
              <div id="test_model_ouroboros-info" class="govuk-hint govuk-character-count__message">
                You can enter up to 200 characters
              </div>
            </div>
          '.to_one_line)
        end

        context 'when aria-describedby attribute for the textarea is passed' do
          let(:textarea_options) { { attributes: { aria: { describedby: 'some-id' } } } }

          it 'has the textarea aria described by as the custom, hint and error id' do
            expect(textarea_element[:'aria-describedby']).to eq('some-id test_model_ouroboros-info ouroboros-hint ouroboros-error')
          end
        end
      end
    end
  end
end
