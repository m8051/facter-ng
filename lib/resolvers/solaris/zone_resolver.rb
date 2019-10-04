# frozen_string_literal: true

module Facter
  module Resolvers
    class SolarisZone < BaseResolver
      @log = Facter::Log.new
      @semaphore = Mutex.new
      @fact_list ||= {}
      class << self
        def resolve(fact_name)
          @semaphore.synchronize do
            result ||= @fact_list[fact_name]
            subscribe_to_manager
            result || build_zone_fact
          end
        end

        private

        def build_zone_fact
          output, status = Open3.capture2('/usr/sbin/zoneadm list -cp')
          if !status.to_s.include?('exit 0') || output.empty?
            @log.error("Could not build zone fact. #{status}")
            return
          end
          zone_regex_pattern = '(\\d+|-):([^:]*):([^:]*):([^:]*):([^:]*):([^:]*):([^:]*)'
          id, name, status, path, uuid, brand, ip_type = output.match(zone_regex_pattern).captures
          zone_fact = {
            brand: brand,
            id: id,
            ip_type: ip_type,
            name: name,
            uuid: uuid
          }
          @fact_list[:zone] = zone_fact
        end
      end
    end
  end
end
