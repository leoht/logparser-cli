# frozen_string_literal: true
module LogParser
  class LineParser
    require 'ipaddr'

    def parse(line)
      parts = line.split(' ')
      return nil if parts.length != 2
      return nil unless valid_ip?(parts.last)

      parts
    end

    private

    def valid_ip?(value)
      IPAddr.new(value)
      true
    rescue IPAddr::InvalidAddressError
      false
    end
  end
end
