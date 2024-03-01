require 'json'

class FixturesLoader
  FIXTURES_PATH = 'node_modules/govuk-frontend/dist/govuk/components'.freeze

  class << self
    def get_fixture_names(component_name)
      @fixtures[component_name].keys
    end

    def get_fixture(component_name, fixture_name)
      @fixtures[component_name][fixture_name]
    end

    def get_tested_fixtures(component_name)
      File.readlines("spec/ccs/frontend_helpers/govuk_frontend/#{component_name.underscore}/fixtures_spec.rb").map do |line|
        start_index = line.index('let(:fixture_name) { ')
        if start_index
          end_index = line.index(' }')
          line[(start_index + 22)...(end_index - 1)]
        end
      end.compact
    end

    def load_fixtures
      fixtures = Dir["#{FIXTURES_PATH}/*/fixtures.json"].to_h do |fixture_file|
        component_fixtures = JSON.parse(File.read(fixture_file)).deep_symbolize_keys

        [
          component_fixtures[:component],
          component_fixtures[:fixtures].to_h do |component_fixture|
            [
              component_fixture[:name],
              {
                options: component_fixture[:options],
                html: component_fixture[:html],
              }
            ]
          end
        ]
      end

      @fixtures = fixtures
    end
  end
end

FixturesLoader.load_fixtures
