# frozen_string_literal: true

module Facter
  module Windows
    class NetworkingFqdn
      FACT_NAME = 'networking.fqdn'

      def call_the_resolver
        domain = Resolvers::Networking.resolve(:domain)
        hostname = Resolvers::Hostname.resolve(:hostname)
        return ResolvedFact.new(FACT_NAME, nil) if !hostname || hostname.empty?

        fact_value = [hostname, domain].compact.join('.')

        ResolvedFact.new(FACT_NAME, fact_value)
      end
    end
  end
end
