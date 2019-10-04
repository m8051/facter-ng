# frozen_string_literal: true

describe 'Solaris Zone' do
  context '#call_the_resolver' do
    it 'returns a fact' do
      hash_fact = { brand: 'solaris',
                    id: '0',
                    ip_type: 'shared',
                    name: 'global',
                    uuid: '' }
      expected_fact = double(Facter::ResolvedFact, name: 'zone', value: hash_fact)
      allow(Facter::Resolvers::SolarisZone).to receive(:resolve).with(:zone).and_return(hash_fact)
      allow(Facter::ResolvedFact).to receive(:new).with('zone', hash_fact).and_return(expected_fact)

      fact = Facter::Solaris::Zone.new
      expect(fact.call_the_resolver).to eq(expected_fact)
    end
  end
end
