# frozen_string_literal: true
module LogParser
  class PageviewsAggregator
    require 'set'

    def initialize
      @total_pageviews_by_path = {}
      @ip_addresses_by_path = {}
    end

    def aggregate(path, ip_address)
      return if path.nil? || ip_address.nil?

      increment_total_pageviews(path)
      set_ip_address_for_path(path, ip_address)

      [path, ip_address]
    end

    def pageviews
      [
        @total_pageviews_by_path,
        map_ips_sets_to_counters(@ip_addresses_by_path),
      ]
    end

    private

    def map_ips_sets_to_counters(ips_sets_hash)
      ips_sets_hash.map do |path, unique_ips|
        [path, unique_ips.length]
      end.to_h
    end

    def increment_total_pageviews(path)
      @total_pageviews_by_path[path] ||= 0
      @total_pageviews_by_path[path] += 1
    end

    def set_ip_address_for_path(path, ip_address)
      @ip_addresses_by_path[path] ||= Set.new
      @ip_addresses_by_path[path] << ip_address
    end
  end
end
