# frozen_string_literal: true

require 'nokogiri/diff'

RSpec::Matchers.define :eq_html do |expected|
  match do |actual|
    expected_html = Nokogiri::HTML(expected)
    actual_html = Nokogiri::HTML(actual)

    expected_html.diff(actual_html).reject { |change, _| change.blank? }.empty?
  end
end
