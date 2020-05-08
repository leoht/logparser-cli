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

    def initialize(file_reader, line_parser, pageviews_aggregator)
      @file_reader = file_reader
      @line_parser = line_parser
      @pageviews_aggregator = pageviews_aggregator
    end

    def parse_and_aggregate_logs(filepath)
      total_views, unique_views = do_parse_and_aggregate(filepath)

      Response.new(
        order_pageviews_by_count_desc(total_views),
        order_pageviews_by_count_desc(unique_views)
      )
    end

    private

    def order_pageviews_by_count_desc(pageviews_hash)
      pageviews_hash.sort_by { |_key, val| -val }.to_h
    end

    def do_parse_and_aggregate(filepath)
      @file_reader.read(filepath) do |line|
        parsed_line = @line_parser.parse(line)
        next if parsed_line.nil?

        path, ip_address = parsed_line
        @pageviews_aggregator.aggregate(path, ip_address)
      end

      @pageviews_aggregator.pageviews
    end
  end
end
