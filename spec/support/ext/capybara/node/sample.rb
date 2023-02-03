class Capybara::Node::Simple
  def to_html
    element = native

    element.remove_attribute('_capybara_raw_value')

    remove_capybara_raw_value(element)

    element.to_s.to_one_line
  end

  private

  def remove_capybara_raw_value(element)
    return unless element.children.any?

    element.children.each do |child_element|
      remove_capybara_raw_value(child_element)

      child_element.remove_attribute('_capybara_raw_value')
    end
  end
end
