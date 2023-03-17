RSpec.shared_context 'and I have a view context' do
  let(:view_context) { TestView.new(:lookup_context, [], :controller) }
end

RSpec.shared_context 'and I have a view context from self' do
  let(:view_context) { self }
end

RSpec.shared_context 'and I have a form from a model' do
  let(:form) do
    ActionView::Helpers::FormBuilder.new(
      TestModel.model_name.singular,
      model,
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
