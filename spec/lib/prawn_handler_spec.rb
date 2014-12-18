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

RSpec.describe 'PrawnHandler' do
  it 'has compatibility with action view' do
    view = ActionView::Base.new
    result = view.render file: File.join('spec', 'fixtures', 'test.pdf.prawn')
    expect(result).to eq '[:explicit_call, :implicit_call]'
  end
end
