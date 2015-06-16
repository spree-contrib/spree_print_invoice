RSpec.describe Spree::Printables::BaseView do
  let(:printable) { Object.new }
  let(:base_view) { Spree::Printables::BaseView.new(printable) }

  describe 'initialization' do
    it 'assigns printable' do
      expect(base_view).to respond_to(:printable)
      expect(base_view.printable).to eq(printable)
    end
  end

  describe '#number' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.number
      end.to raise_error(NotImplementedError, 'Please implement number')
    end
  end

  describe '#firstname' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.firstname
      end.to raise_error(NotImplementedError, 'Please implement firstname')
    end
  end

  describe '#lastname' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.lastname
      end.to raise_error(NotImplementedError, 'Please implement lastname')
    end
  end

  describe '#total' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.total
      end.to raise_error(NotImplementedError, 'Please implement total')
    end
  end

  describe '#email' do
    it 'raises a NotImplementedError' do
      expect do
        base_view.email
      end.to raise_error(NotImplementedError, 'Please implement email')
    end
  end
end
