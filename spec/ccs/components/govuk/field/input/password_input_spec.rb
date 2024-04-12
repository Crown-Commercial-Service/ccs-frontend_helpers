# frozen_string_literal: true

require 'ccs/components/govuk/field/input/password_input'

RSpec.describe CCS::Components::GovUK::Field::Input::PasswordInput do
  include_context 'and I have a view context'

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:label_element) { Capybara::Node::Simple.new(result).find('label.govuk-label') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:password_input_element) { Capybara::Node::Simple.new(result).find('input.govuk-input') }
  let(:show_hide_password_element) { Capybara::Node::Simple.new(result).find('button.govuk-button', visible: false) }

  let(:result) { govuk_password_input.render }

  let(:attribute) { 'ouroboros' }
  let(:options) do
    {
      form_group: form_group_options,
      label: {
        text: 'Enter your password'
      }.merge(label_options)
    }.merge(password_input_options)
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Enter your password',
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: form_group_options,
      label: {
        text: 'Enter your password'
      }.merge(label_options),
      hint: {
        text: 'It should be super secret'
      }.merge(hint_options)
    }.merge(password_input_options)
  end
  let(:form_group_options) { {} }
  let(:label_options) { {} }
  let(:hint_options) { {} }
  let(:password_input_options) { {} }
  let(:test_model) { TestModel.new }

  describe '.render' do
    let(:govuk_password_input) { described_class.new(attribute: attribute, error_message: error_message, context: view_context, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Enter your password
          </label>
          <div class="govuk-input__wrapper govuk-password-input__wrapper">
            <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
            <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
              Show
            </button>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_password_input) { described_class.new(attribute: attribute, context: view_context, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:password_input_options) { { classes: 'my-custom-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group govuk-password-input my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(password_input_element[:class]).to eq('govuk-input govuk-password-input__input govuk-js-password-input-input my-custom-input-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:password_input_options) { { attributes: { id: 'my-custom-input-id' } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(password_input_element[:id]).to eq('my-custom-input-id')
        expect(show_hide_password_element[:'aria-controls']).to eq('my-custom-input-id')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when a custom name is passed' do
      let(:password_input_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the input' do
        expect(password_input_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom autocomplete is passed' do
      let(:password_input_options) { { attributes: { autocomplete: 'my-custom-autocomplete' } } }

      it 'has the custom autocomplete in the input' do
        expect(password_input_element[:autocomplete]).to eq('my-custom-autocomplete')
      end
    end

    context 'when custom attributes are passed' do
      let(:password_input_options) { { attributes: { pattern: '[0-9]*', value: 'Eunie', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the additional attributes for the input' do
        expect(password_input_element[:value]).to eq('Eunie')
        expect(password_input_element[:pattern]).to eq('[0-9]*')
        expect(password_input_element[:'aria-describedby']).to eq('some-id')
        expect(password_input_element[:'data-test']).to eq('my data value')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when translation options are provided for the password input options' do
      let(:password_input_options) do
        {
          show_password_text: 'show_password_text',
          hide_password_text: 'hide_password_text',
          show_password_aria_label_text: 'show_password_aria_label_text',
          hide_password_aria_label_text: 'hide_password_aria_label_text',
          password_shown_announcement_text: 'password_shown_announcement_text',
          password_hidden_announcement_text: 'password_hidden_announcement_text'
        }
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the translations as data attributes' do
        expect(form_group_element[:'data-i18n.show-password']).to eq('show_password_text')
        expect(form_group_element[:'data-i18n.hide-password']).to eq('hide_password_text')
        expect(form_group_element[:'data-i18n.show-password-aria-label']).to eq('show_password_aria_label_text')
        expect(form_group_element[:'data-i18n.hide-password-aria-label']).to eq('hide_password_aria_label_text')
        expect(form_group_element[:'data-i18n.password-shown-announcement']).to eq('password_shown_announcement_text')
        expect(form_group_element[:'data-i18n.password-hidden-announcement']).to eq('password_hidden_announcement_text')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when a class is given for the button' do
      let(:password_input_options) { { button: { classes: 'my-custom-button-class' } } }

      it 'has the classes on the button' do
        expect(show_hide_password_element[:class]).to eq('govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle my-custom-button-class')
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                It should be super secret
              </div>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" aria-describedby="ouroboros-hint">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
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

        it 'has the custom id for the hint and the input has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(password_input_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and hint id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must enter your favourite character' }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div data-module="govuk-password-input" class="govuk-form-group govuk-form-group--error govuk-password-input" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Enter your password
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <div class="govuk-input__wrapper govuk-password-input__wrapper">
              <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input govuk-input--error" aria-describedby="ouroboros-error">
              <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                Show
              </button>
            </div>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and error id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must enter your favourite character' }
      let(:options) { options_with_hint }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div data-module="govuk-password-input" class="govuk-form-group govuk-form-group--error govuk-password-input" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Enter your password
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              It should be super secret
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <div class="govuk-input__wrapper govuk-password-input__wrapper">
              <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input govuk-input--error" aria-describedby="ouroboros-hint ouroboros-error">
              <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                Show
              </button>
            </div>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom, hint and error id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when considering before and after input' do
      let(:before_input) { tag.p('I am before input', class: 'govuk-body') }
      let(:after_input) { tag.p('I am after input', class: 'govuk-body') }

      context 'when there is a before input' do
        let(:password_input_options) { { before_input: before_input } }

        it 'renders the text input with the before input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <p class="govuk-body">
                  I am before input
                </p>
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
              </div>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is an after input' do
        let(:password_input_options) { { after_input: after_input } }

        it 'renders the text input with the after input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
                <p class="govuk-body">
                  I am after input
                </p>
              </div>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is a before and after input' do
        let(:password_input_options) { { before_input: before_input, after_input: after_input } }

        it 'renders the text input with the before and after input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <p class="govuk-body">
                  I am before input
                </p>
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
                <p class="govuk-body">
                  I am after input
                </p>
              </div>
            </div>
          '.to_one_line)
        end
      end
    end
  end

  describe '.render with model' do
    let(:govuk_password_input) { described_class.new(attribute: attribute, model: test_model, context: view_context, **options) }

    let(:default_html) do
      '
        <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Enter your password
          </label>
          <div class="govuk-input__wrapper govuk-password-input__wrapper">
            <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
            <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
              Show
            </button>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:password_input_options) { { classes: 'my-custom-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group govuk-password-input my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(password_input_element[:class]).to eq('govuk-input govuk-password-input__input govuk-js-password-input-input my-custom-input-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:password_input_options) { { attributes: { id: 'my-custom-input-id' } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(password_input_element[:id]).to eq('my-custom-input-id')
        expect(show_hide_password_element[:'aria-controls']).to eq('my-custom-input-id')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when a custom name is passed' do
      let(:password_input_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the input' do
        expect(password_input_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom autocomplete is passed' do
      let(:password_input_options) { { attributes: { autocomplete: 'my-custom-autocomplete' } } }

      it 'has the custom autocomplete in the input' do
        expect(password_input_element[:autocomplete]).to eq('my-custom-autocomplete')
      end
    end

    context 'when the model has a value' do
      before { test_model.ouroboros = 'Eunie' }

      it 'has the value for the input' do
        expect(password_input_element[:value]).to eq('Eunie')
      end
    end

    context 'when custom attributes are passed' do
      let(:password_input_options) { { attributes: { pattern: '[0-9]*', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      it 'has the additional attributes for the input' do
        expect(password_input_element[:pattern]).to eq('[0-9]*')
        expect(password_input_element[:'aria-describedby']).to eq('some-id')
        expect(password_input_element[:'data-test']).to eq('my data value')
      end
    end

    context 'when translation options are provided for the password input options' do
      let(:password_input_options) do
        {
          show_password_text: 'show_password_text',
          hide_password_text: 'hide_password_text',
          show_password_aria_label_text: 'show_password_aria_label_text',
          hide_password_aria_label_text: 'hide_password_aria_label_text',
          password_shown_announcement_text: 'password_shown_announcement_text',
          password_hidden_announcement_text: 'password_hidden_announcement_text'
        }
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the translations as data attributes' do
        expect(form_group_element[:'data-i18n.show-password']).to eq('show_password_text')
        expect(form_group_element[:'data-i18n.hide-password']).to eq('hide_password_text')
        expect(form_group_element[:'data-i18n.show-password-aria-label']).to eq('show_password_aria_label_text')
        expect(form_group_element[:'data-i18n.hide-password-aria-label']).to eq('hide_password_aria_label_text')
        expect(form_group_element[:'data-i18n.password-shown-announcement']).to eq('password_shown_announcement_text')
        expect(form_group_element[:'data-i18n.password-hidden-announcement']).to eq('password_hidden_announcement_text')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when a class is given for the button' do
      let(:password_input_options) { { button: { classes: 'my-custom-button-class' } } }

      it 'has the classes on the button' do
        expect(show_hide_password_element[:class]).to eq('govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle my-custom-button-class')
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                It should be super secret
              </div>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" aria-describedby="ouroboros-hint">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
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

        it 'has the custom id for the hint and the input has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(password_input_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and hint id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div data-module="govuk-password-input" class="govuk-form-group govuk-form-group--error govuk-password-input" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Enter your password
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <div class="govuk-input__wrapper govuk-password-input__wrapper">
              <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input govuk-input--error" aria-describedby="ouroboros-error">
              <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                Show
              </button>
            </div>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and error id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }

      before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div data-module="govuk-password-input" class="govuk-form-group govuk-form-group--error govuk-password-input" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Enter your password
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              It should be super secret
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <div class="govuk-input__wrapper govuk-password-input__wrapper">
              <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input govuk-input--error" aria-describedby="ouroboros-hint ouroboros-error">
              <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                Show
              </button>
            </div>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom, hint and error id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when considering before and after input' do
      let(:before_input) { tag.p('I am before input', class: 'govuk-body') }
      let(:after_input) { tag.p('I am after input', class: 'govuk-body') }

      context 'when there is a before input' do
        let(:password_input_options) { { before_input: before_input } }

        it 'renders the text input with the before input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <p class="govuk-body">
                  I am before input
                </p>
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
              </div>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is an after input' do
        let(:password_input_options) { { after_input: after_input } }

        it 'renders the text input with the after input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
                <p class="govuk-body">
                  I am after input
                </p>
              </div>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is a before and after input' do
        let(:password_input_options) { { before_input: before_input, after_input: after_input } }

        it 'renders the text input with the before and after input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <p class="govuk-body">
                  I am before input
                </p>
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
                <p class="govuk-body">
                  I am after input
                </p>
              </div>
            </div>
          '.to_one_line)
        end
      end
    end
  end

  describe '.render with form' do
    include_context 'and I have a form from a model'

    let(:govuk_password_input) { described_class.new(attribute: attribute, form: form, context: view_context, **options) }

    let(:default_html) do
      '
        <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Enter your password
          </label>
          <div class="govuk-input__wrapper govuk-password-input__wrapper">
            <input spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" type="password" name="test_model[ouroboros]" id="test_model_ouroboros">
            <button name="button" type="button" aria-controls="test_model_ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
              Show
            </button>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:password_input_options) { { classes: 'my-custom-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group govuk-password-input my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(password_input_element[:class]).to eq('govuk-input govuk-password-input__input govuk-js-password-input-input my-custom-input-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:password_input_options) { { attributes: { id: 'my-custom-input-id' } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(password_input_element[:id]).to eq('my-custom-input-id')
        expect(show_hide_password_element[:'aria-controls']).to eq('my-custom-input-id')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when a custom name is passed' do
      let(:password_input_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the input' do
        expect(password_input_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom autocomplete is passed' do
      let(:password_input_options) { { attributes: { autocomplete: 'my-custom-autocomplete' } } }

      it 'has the custom autocomplete in the input' do
        expect(password_input_element[:autocomplete]).to eq('my-custom-autocomplete')
      end
    end

    context 'when the model has a value' do
      before { test_model.ouroboros = 'Eunie' }

      it 'has nil value for the input' do
        expect(password_input_element[:value]).to be_nil
      end
    end

    context 'when custom attributes are passed' do
      let(:password_input_options) { { attributes: { pattern: '[0-9]*', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      it 'has the additional attributes for the input' do
        expect(password_input_element[:pattern]).to eq('[0-9]*')
        expect(password_input_element[:'aria-describedby']).to eq('some-id')
        expect(password_input_element[:'data-test']).to eq('my data value')
      end
    end

    context 'when translation options are provided for the password input options' do
      let(:password_input_options) do
        {
          show_password_text: 'show_password_text',
          hide_password_text: 'hide_password_text',
          show_password_aria_label_text: 'show_password_aria_label_text',
          hide_password_aria_label_text: 'hide_password_aria_label_text',
          password_shown_announcement_text: 'password_shown_announcement_text',
          password_hidden_announcement_text: 'password_hidden_announcement_text'
        }
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the translations as data attributes' do
        expect(form_group_element[:'data-i18n.show-password']).to eq('show_password_text')
        expect(form_group_element[:'data-i18n.hide-password']).to eq('hide_password_text')
        expect(form_group_element[:'data-i18n.show-password-aria-label']).to eq('show_password_aria_label_text')
        expect(form_group_element[:'data-i18n.hide-password-aria-label']).to eq('hide_password_aria_label_text')
        expect(form_group_element[:'data-i18n.password-shown-announcement']).to eq('password_shown_announcement_text')
        expect(form_group_element[:'data-i18n.password-hidden-announcement']).to eq('password_hidden_announcement_text')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when a class is given for the button' do
      let(:password_input_options) { { button: { classes: 'my-custom-button-class' } } }

      it 'has the classes on the button' do
        expect(show_hide_password_element[:class]).to eq('govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle my-custom-button-class')
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Enter your password
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                It should be super secret
              </div>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <input spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" aria-describedby="ouroboros-hint" type="password" name="test_model[ouroboros]" id="test_model_ouroboros">
                <button name="button" type="button" aria-controls="test_model_ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
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

        it 'has the custom id for the hint and the input has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(password_input_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and hint id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div data-module="govuk-password-input" class="govuk-form-group govuk-form-group--error govuk-password-input" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Enter your password
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <div class="govuk-input__wrapper govuk-password-input__wrapper">
              <input spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input govuk-input--error" aria-describedby="ouroboros-error" type="password" name="test_model[ouroboros]" id="test_model_ouroboros">
              <button name="button" type="button" aria-controls="test_model_ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                Show
              </button>
            </div>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and error id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }

      before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div data-module="govuk-password-input" class="govuk-form-group govuk-form-group--error govuk-password-input" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Enter your password
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              It should be super secret
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <div class="govuk-input__wrapper govuk-password-input__wrapper">
              <input spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input govuk-input--error" aria-describedby="ouroboros-hint ouroboros-error" type="password" name="test_model[ouroboros]" id="test_model_ouroboros">
              <button name="button" type="button" aria-controls="test_model_ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                Show
              </button>
            </div>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:password_input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom, hint and error id' do
          expect(password_input_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when considering before and after input' do
      let(:before_input) { tag.p('I am before input', class: 'govuk-body') }
      let(:after_input) { tag.p('I am after input', class: 'govuk-body') }

      context 'when there is a before input' do
        let(:password_input_options) { { before_input: before_input } }

        it 'renders the text input with the before input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <p class="govuk-body">
                  I am before input
                </p>
                <input spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" type="password" name="test_model[ouroboros]" id="test_model_ouroboros">
                <button name="button" type="button" aria-controls="test_model_ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
              </div>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is an after input' do
        let(:password_input_options) { { after_input: after_input } }

        it 'renders the text input with the after input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <input spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" type="password" name="test_model[ouroboros]" id="test_model_ouroboros">
                <button name="button" type="button" aria-controls="test_model_ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
                <p class="govuk-body">
                  I am after input
                </p>
              </div>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is a before and after input' do
        let(:password_input_options) { { before_input: before_input, after_input: after_input } }

        it 'renders the text input with the before and after input' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Enter your password
              </label>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <p class="govuk-body">
                  I am before input
                </p>
                <input spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" type="password" name="test_model[ouroboros]" id="test_model_ouroboros">
                <button name="button" type="button" aria-controls="test_model_ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
                <p class="govuk-body">
                  I am after input
                </p>
              </div>
            </div>
          '.to_one_line)
        end
      end
    end
  end
end
