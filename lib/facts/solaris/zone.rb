# frozen_string_literal: true

module Facter
  module Solaris
    class Zone
      FACT_NAME = 'zone'

      def call_the_resolver
        fact_value = Facter::Resolvers::SolarisZone.resolve(:zone)
        ResolvedFact.new(FACT_NAME, fact_value)
      end
    end
  end
end
