# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Button, '#validate_fixtures', type: :helper do
  component_name = 'button'
  fixture_list = {
    'default' => true,
    'disabled' => true,
    'link' => true,
    'start' => true,
    'start link' => true,
    'input' => true,
    'input disabled' => true,
    'prevent double click' => true,
    'secondary' => true,
    'warning' => true,
    'inverse' => true,
    'attributes' => true,
    'link attributes' => true,
    'input attributes' => true,
    'classes' => true,
    'link classes' => true,
    'input classes' => true,
    'name' => true,
    'type' => true,
    'input type' => true,
    'explicit link' => true,
    'no href' => true,
    'value' => true,
    'html' => true,
    'no type' => true,
    'no data-prevent-double-click' => true,
    "don't prevent double click" => true,
    'id' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, component_name)

  it 'has only the tested fixtures' do
    expect(fixture_list.keys.sort).to eq(FixturesLoader.get_fixture_names(:govuk_frontend, component_name).sort)
  end

  FixturesLoader.get_fixture_names(:govuk_frontend, component_name).each do |fixture|
    if fixture_list[fixture]
      it "has spec'd the '#{fixture}' fixture" do
        expect(fixture_list).to have_key(fixture)
        expect(tested_fixtures).to include(fixture)
      end
    else
      it "has skipped the '#{fixture}' fixture" do
        expect(fixture_list).to have_key(fixture)
        expect(tested_fixtures).not_to include(fixture)
      end
    end
  end
end
