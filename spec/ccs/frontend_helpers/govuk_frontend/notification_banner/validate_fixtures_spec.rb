# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::NotificationBanner, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'paragraph as html heading' => true,
    'with text as html' => true,
    'with type as success' => true,
    'success with custom html' => true,
    'with a list' => true,
    'with long heading' => true,
    'with lots of content' => true,
    'auto-focus disabled, with type as success' => true,
    'auto-focus explicitly enabled, with type as success' => true,
    'role=alert overridden to role=region, with type as success' => true,
    'custom tabindex' => true,
    'custom title' => true,
    'title as html' => true,
    'title html as text' => true,
    'custom title heading level' => true,
    'custom title id' => true,
    'custom title id with type as success' => true,
    'custom text' => true,
    'html as text' => true,
    'custom role' => true,
    'classes' => true,
    'attributes' => true,
    'with invalid type' => false
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'notification-banner')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'notification-banner').each do |fixture|
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
