require 'test/unit'

module Prawn
  class Document
    def initialize
      @calls = []
    end
    
    def explicit_call
      @calls << :explicit_call
    end
    
    def implicit_call
      @calls << :implicit_call
    end
    
    def render
      @calls.inspect
    end
  end
end

require 'action_view'
load File.dirname(__FILE__) + '/../init.rb'

class PrawnHandlerTest < Test::Unit::TestCase
  def test_compatibility_with_action_view
    view = ActionView::Base.new
    result = view.render :file => File.dirname(__FILE__) + '/test.pdf.prawn'
    assert_equal "[:explicit_call, :implicit_call]", result
  end
end
