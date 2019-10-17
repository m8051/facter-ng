# frozen_string_literal: true

module Facter
  module Ubuntu
    class Kernelrelease
      FACT_NAME = 'kernelrelease'

      def call_the_resolver
        fact_value = Resolvers::Uname.resolve(:kernelrelease)
        ResolvedFact.new(FACT_NAME, fact_value)
      end
    end
  end
end
