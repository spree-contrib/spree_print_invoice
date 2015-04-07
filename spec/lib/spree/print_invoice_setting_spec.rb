RSpec.describe Spree::PrintInvoiceSetting do
  subject { described_class.new }

  describe '#page_sizes' do
    it 'has a list of page sizes' do
      expect(subject.page_sizes).to be_a(Array)
      expect(subject.page_sizes.size).to be(50)
    end
  end

  describe '#page_layouts' do
    it 'has a list of layouts' do
      expect(subject.page_layouts).to be_a(Array)
      expect(subject.page_layouts).to match_array %w(landscape portrait)
    end
  end

  describe '#use_sequential_number?' do
    context 'when :next_number set' do
      before { subject.next_number = 100 }

      it 'uses sequential number' do
        expect(subject.use_sequential_number?).to be(true)
      end
    end

    context 'when :next_number nil' do
      before { subject.next_number = nil }

      it 'does not use sequential number' do
        expect(subject.use_sequential_number?).to be(false)
      end
    end
  end

  describe '#increase_invoice_number' do
    it 'increases invoice numer by one' do
      subject.next_number = 100
      subject.increase_invoice_number
      expect(subject.next_number).to be(101)
    end
  end

  describe '#font_faces' do
    it 'has a list of font faces' do
      expect(subject.font_faces).to be_a(Array)
      expect(subject.font_faces).to match_array %w(Courier Helvetica Times-Roman)
    end
  end

  describe '#font_sizes' do
    it 'has a list of font sizes' do
      expect(subject.font_sizes).to be_a(Array)
      expect(subject.font_sizes.first).to be(7)
      expect(subject.font_sizes.last).to  be(14)
    end
  end

  describe '#logo_scaling' do
    it 'converts logo scale to percent' do
      subject.logo_scale = 100
      expect(subject.logo_scaling).to be(1.0)
    end
  end

  describe '#print_templates' do
    before { @print_buttons = subject.print_buttons }

    it 'returns array of print template names from print buttons string' do
      subject.print_buttons = 'foo,baz'
      expect(subject.print_templates).to eq(%w(foo baz))
    end

    context 'when print buttons has spaces' do
      it 'ignores them' do
        subject.print_buttons = ' foo , baz '
        expect(subject.print_templates).to eq(%w(foo baz))
      end
    end

    context 'when print buttons are empty' do
      it 'returns empty array' do
        subject.print_buttons = ''
        expect(subject.print_templates).to eq([])
      end
    end

    context 'when print buttons are nil' do
      it 'returns empty array' do
        subject.print_buttons = nil
        expect(subject.print_templates).to eq([])
      end
    end

    after { subject.print_buttons = @print_buttons }
  end
end
