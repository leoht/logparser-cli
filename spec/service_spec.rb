# frozen_string_literal: true
describe LogParser::Service do
  let(:file_reader) { LogParser::FileReader.new }
  let(:line_parser) { LogParser::LineParser.new }
  let(:aggregator) { LogParser::PageviewsAggregator.new }
  let(:parser) do
    LogParser::Service.new(
      file_reader,
      line_parser,
      aggregator
    )
  end

  it 'should return correct total pageviews ordered by count desc' do
    expect(
      parser.parse_and_aggregate_logs('./spec/fixtures/test_log.log')
    ).to(satisfy) do |response|
      response.total_pageviews.to_a == {
        "/help_page/1" => 5,
        "/contact" => 3,
        "/about/2" => 3,
        "/home" => 2,
        "/index" => 1,
      }.to_a
    end
  end

  it 'should return correct unique pageviews ordered by count desc' do
    expect(
      parser.parse_and_aggregate_logs('./spec/fixtures/test_log.log')
    ).to(satisfy) do |response|
      response.unique_pageviews.to_a == {
        "/help_page/1" => 4,
        "/contact" => 2,
        "/about/2" => 2,
        "/index" => 1,
        "/home" => 1,
      }.to_a
    end
  end
end
