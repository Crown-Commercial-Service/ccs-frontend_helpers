RSpec.shared_context 'and I have a view context' do
  let(:view_context) { TestView.new(:lookup_context, [], :controller) }
end

RSpec.shared_context 'and I have a view context from self' do
  let(:view_context) { self }
end

RSpec.shared_context 'and I have loaded the GOV.UK Frontend fixture' do
  let(:fixture) { FixturesLoader.get_fixture(:govuk_frontend, component_name, fixture_name) }
  let(:fixture_options) { fixture[:options] }
  let(:fixture_html) { fixture[:html].to_one_line }
end

RSpec.shared_context 'and I have loaded the CCS Frontend fixture' do
  let(:fixture) { FixturesLoader.get_fixture(:ccs_frontend, component_name, fixture_name) }
  let(:fixture_options) { fixture[:options] }
  let(:fixture_html) { fixture[:html].to_one_line }
end

RSpec.shared_context 'and I am using a field fixture' do
  # We automatically add an ID for the fromgroup in our helper
  let(:fixture_html) { fixture[:html].to_one_line.sub('<div class="govuk-form-group', "<div id=\"#{fixture_options[:name]}-form-group\" class=\"govuk-form-group") }
end

RSpec.shared_context 'and I have a form from a model' do
  let(:form) do
    ActionView::Helpers::FormBuilder.new(
      TestModel.model_name.singular,
      test_model,
      view_context,
      {}
    )
  end
end

RSpec.shared_context 'and I have a form' do
  let(:form) do
    ActionView::Helpers::FormBuilder.new(
      TestModel.model_name.singular,
      TestModel.new,
      view_context,
      {}
    )
  end
end
