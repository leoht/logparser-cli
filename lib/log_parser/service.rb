# frozen_string_literal: true
module LogParser
  class Service
    class Response
      attr_reader :total_pageviews, :unique_pageviews

      def initialize(total, unique)
        @total_pageviews = total
        @unique_pageviews = unique
      end
    end
    
  end
end
