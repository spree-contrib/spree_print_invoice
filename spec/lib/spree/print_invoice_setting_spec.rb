RSpec.describe Spree::PrintInvoiceSetting do

  subject { described_class.new }

  context '.page_sizes' do
    it 'has a list of page sizes' do
      expect(subject.page_sizes).to be_a(Array)
      expect(subject.page_sizes.size).to be(50)
    end
  end

  context '.page_layouts' do
    it 'has a list of layouts' do
      expect(subject.page_layouts).to be_a(Array)
      expect(subject.page_layouts).to match_array %w(landscape portrait)
    end
  end

  context '.use_sequential_number?' do
    it 'uses sequential number when :next_number set' do
      subject.next_number = 100
      expect(subject.use_sequential_number?).to be(true)
    end

    it 'does not use sequential number when :next_number nil' do
      subject.next_number = nil
      expect(subject.use_sequential_number?).to be(false)
    end
  end

  context '.increase_invoice_number' do
    it 'increases invoice numer by one' do
      subject.next_number = 100
      subject.increase_invoice_number
      expect(subject.next_number).to be(101)
    end
  end

  context '.font_faces' do
    it 'has a list of font faces' do
      expect(subject.font_faces).to be_a(Array)
      expect(subject.font_faces).to match_array %w(Courier Helvetica Times-Roman)
    end
  end

  context '.font_sizes' do
    it 'has a list of font sizes' do
      expect(subject.font_sizes).to be_a(Array)
      expect(subject.font_sizes.first).to be(7)
      expect(subject.font_sizes.last).to  be(14)
    end
  end

  context '.logo_scaling' do
    it 'converts logo scale to percent' do
      subject.logo_scale = 100
      expect(subject.logo_scaling).to be(1.0)
    end
  end
end
