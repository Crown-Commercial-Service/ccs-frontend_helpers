# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/button'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Button, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_button from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'button' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_button(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'disabled'" do
      let(:fixture_name) { 'disabled' }
      let(:result) { govuk_button(fixture_options[:text], attributes: { disabled: fixture_options[:disabled] }) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'link'" do
      let(:fixture_name) { 'link' }
      let(:result) { govuk_button(fixture_options[:text], href: fixture_options[:href]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'start'" do
      let(:fixture_name) { 'start' }
      let(:result) { govuk_button(fixture_options[:text], is_start_button: fixture_options[:isStartButton]) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'start link'" do
      let(:fixture_name) { 'start link' }
      let(:result) { govuk_button(fixture_options[:text], href: fixture_options[:href], is_start_button: fixture_options[:isStartButton]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'input'" do
      include_context 'and I have a view context from self'
      include_context 'and I have a form'

      let(:fixture_name) { 'input' }
      let(:result) { govuk_button(fixture_options[:text], form: form, attributes: { name: fixture_options[:name] }) }

      it 'has HTML matching the fixture' do
        # Rails renders input tags with data-disable-with by default
        expect(result).to eq_html(fixture_html.gsub('<input ', "<input data-disable-with=\"#{fixture_options[:text]}\" "))
      end
    end

    context "when the fixture is 'input disabled'" do
      include_context 'and I have a view context from self'
      include_context 'and I have a form'

      let(:fixture_name) { 'input disabled' }
      let(:result) { govuk_button(fixture_options[:text], form: form, attributes: { name: fixture_options[:name], disabled: fixture_options[:disabled] }) }

      it 'has HTML matching the fixture' do
        # Rails renders input tags with data-disable-with by default
        expect(result).to eq_html(fixture_html.gsub('<input ', "<input data-disable-with=\"#{fixture_options[:text]}\" "))
      end
    end

    context "when the fixture is 'prevent double click'" do
      let(:fixture_name) { 'prevent double click' }
      let(:result) { govuk_button(fixture_options[:text], attributes: { data: { 'prevent-double-click': true } }) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'with active state'" do
      let(:fixture_name) { 'with active state' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hover state'" do
      let(:fixture_name) { 'with hover state' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with focus state'" do
      let(:fixture_name) { 'with focus state' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'secondary'" do
      let(:fixture_name) { 'secondary' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'secondary disabled'" do
      let(:fixture_name) { 'secondary disabled' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name], disabled: fixture_options[:disabled] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'secondary link'" do
      let(:fixture_name) { 'secondary link' }
      let(:result) { govuk_button(fixture_options[:text], href: fixture_options[:href], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'warning'" do
      let(:fixture_name) { 'warning' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'warning disabled'" do
      let(:fixture_name) { 'warning disabled' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name], disabled: fixture_options[:disabled] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'warning link'" do
      let(:fixture_name) { 'warning link' }
      let(:result) { govuk_button(fixture_options[:text], href: fixture_options[:href], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'inverse'" do
      let(:fixture_name) { 'inverse' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'inverse disabled'" do
      let(:fixture_name) { 'inverse disabled' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes], attributes: { name: fixture_options[:name], disabled: fixture_options[:disabled] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'inverse link'" do
      let(:fixture_name) { 'inverse link' }
      let(:result) { govuk_button(fixture_options[:text], href: fixture_options[:href], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'inverse start'" do
      let(:fixture_name) { 'inverse start' }
      let(:result) { govuk_button(fixture_options[:text], href: fixture_options[:href], classes: fixture_options[:classes], is_start_button: fixture_options[:isStartButton]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_button(fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'link attributes'" do
      let(:fixture_name) { 'link attributes' }
      let(:result) { govuk_button(fixture_options[:text], href: '#', attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'input attributes'" do
      include_context 'and I have a view context from self'
      include_context 'and I have a form'

      let(:fixture_name) { 'input attributes' }
      let(:result) { govuk_button(fixture_options[:text], form: form, attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        # Rails renders input tags with data-disable-with and name of commit by default
        expect(result).to eq_html(fixture_html.gsub('<input ', "<input name=\"commit\" data-disable-with=\"#{fixture_options[:text]}\" "))
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_button(fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'link classes'" do
      let(:fixture_name) { 'link classes' }
      let(:result) { govuk_button(fixture_options[:text], href: '#', classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'input classes'" do
      include_context 'and I have a view context from self'
      include_context 'and I have a form'

      let(:fixture_name) { 'input classes' }
      let(:result) { govuk_button(fixture_options[:text], form: form, classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        # Rails renders input tags with data-disable-with and name of commit by default
        expect(result).to eq_html(fixture_html.gsub('<input ', "<input name=\"commit\" data-disable-with=\"#{fixture_options[:text]}\" "))
      end
    end

    context "when the fixture is 'name'" do
      let(:fixture_name) { 'name' }
      let(:result) { govuk_button(fixture_options[:text], attributes: { name: fixture_options[:name] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'type'" do
      let(:fixture_name) { 'type' }
      let(:result) { govuk_button(fixture_options[:text], attributes: { type: fixture_options[:type] }) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'input type'" do
      include_context 'and I have a view context from self'
      include_context 'and I have a form'

      let(:fixture_name) { 'input type' }
      let(:result) { govuk_button(fixture_options[:text], form: form, attributes: { type: fixture_options[:type] }) }

      it 'has HTML matching the fixture' do
        # Rails renders input tags with data-disable-with and name of commit by default
        expect(result).to eq_html(fixture_html.gsub('<input ', "<input name=\"commit\" data-disable-with=\"#{fixture_options[:text]}\" "))
      end
    end

    context "when the fixture is 'explicit link'" do
      let(:fixture_name) { 'explicit link' }
      let(:result) { govuk_button(fixture_options[:text], href: fixture_options[:href]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'no href'" do
      let(:fixture_name) { 'no href' }
      let(:result) { govuk_button(fixture_options[:text], href: '#') }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'value'" do
      let(:fixture_name) { 'value' }
      let(:result) { govuk_button(fixture_options[:text], attributes: { value: fixture_options[:value] }) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_button(fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'no type'" do
      let(:fixture_name) { 'no type' }
      let(:result) { govuk_button(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'no data-prevent-double-click'" do
      let(:fixture_name) { 'no data-prevent-double-click' }
      let(:result) { govuk_button(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'don't prevent double click'" do
      let(:fixture_name) { "don't prevent double click" }
      let(:result) { govuk_button(fixture_options[:text], attributes: { data: { 'prevent-double-click': fixture_options[:preventDoubleClick] } }) }

      it 'has HTML matching the fixture' do
        # Rails renders submit tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'id'" do
      include_context 'and I have a view context from self'
      include_context 'and I have a form'

      let(:fixture_name) { 'id' }
      let(:result) { govuk_button(fixture_options[:text], form: form, attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        # Rails renders input tags with data-disable-with by default
        expect(result).to eq_html(fixture_html.gsub('<input ', "<input name=\"commit\" data-disable-with=\"#{fixture_options[:text]}\" "))
      end
    end
  end
end
