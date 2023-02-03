require 'active_model'
require 'action_view'

class TestModel
  include ActiveModel::Model

  attr_accessor :ouroboros,
                :xenoblade_chronicles_3,
                :xenoblade_chronicles_3_day,
                :xenoblade_chronicles_3_dd,
                :xenoblade_chronicles_3_month,
                :xenoblade_chronicles_3_mm,
                :xenoblade_chronicles_3_year,
                :xenoblade_chronicles_3_yyyy
end

class TestView < ActionView::Base; end
