RSpec.describe OpenHash do
  context 'calling' do
    let(:hash) { { name: 'John Smith', hometown: { city: 'London' } } }
    let(:ohash) { OpenHash.new hash }

    it 'gets name' do
      expect(ohash.name).to eq('John Smith')
    end

    it 'gets hometown.city' do
      expect(ohash.hometown.city).to eq('London')
    end

    it 'gets inexistent key' do
      expect(ohash.nothing).to be_nil?
    end
  end

  context 'assignment' do
    let(:ohash) { OpenHash.new }

    it 'assigns name' do
      ohash.name = 'Piter Lee'
      expect(ohash.name).to eq('Piter Lee')
    end

    it 'assigns hometown.city' do
      ohash.hometown.city = 'Guangzhou'
      expect(ohash.hometown.city).to eq('Guangzhou')
    end

    it 'assigns parents.father.name' do
      ohash.parents.father.name = 'Heron Lee'
      expect(ohash.parents.father.name).to eq('Heron Lee')
    end
  end
end
