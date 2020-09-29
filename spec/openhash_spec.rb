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

  context 'calling array' do
    let(:hash) { { cities: [{ name: "London" }, { name: "Paris" }] } }
    let(:ohash) { OpenHash.new hash }

    it 'gets cities' do
      expect(ohash.cities).to be_instance_of(Array)
    end

    it 'gets first ciry name' do
      expect(ohash.cities[0].name).to eq('London')
    end

    it 'gets last ciry name' do
      expect(ohash.cities[-1].name).to eq('Paris')
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

    context 'blackhole' do
      let(:ohash) { OpenHash.new }

      it 'equals nil' do
        expect(ohash.nothing.nil?).to eq(true)
        expect(ohash.nothing == nil).to eq(true)
        expect(ohash.nothing === nil).to eq(true)
      end

      it 'raises an error for operators which not a methods of NilClass' do
        expect { ohash.nothing > 100 }.to raise_error(NoMethodError)
        expect { ohash.nothing < 100 }.to raise_error(NoMethodError)
        expect { ohash.nothing[100] }.to raise_error(NoMethodError)
      end
    end
  end
end
