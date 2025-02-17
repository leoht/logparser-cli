# frozen_string_literal: true
describe LogParser::PageviewsAggregator do
  let(:aggregator) { LogParser::PageviewsAggregator.new }

  before(:each) do
    aggregator.aggregate('/about', '192.168.10.11')
    aggregator.aggregate('/about', '192.168.10.12')
    aggregator.aggregate('/about', '192.168.10.13')

    aggregator.aggregate('/posts/1', '192.168.10.12')
    aggregator.aggregate('/posts/1', '192.168.10.12')
    aggregator.aggregate('/posts/1', '192.168.10.14')
  end

  it 'should aggregate total number of views' do
    expect(aggregator.pageviews).to(satisfy) do |response|
      totals, _ = response
      totals == {
        '/about' => 3,
        '/posts/1' => 3,
      }
    end
  end

  it 'should aggregate unique number of views' do
    expect(aggregator.pageviews).to(satisfy) do |response|
      _, uniques = response
      uniques == {
        '/about' => 3,
        '/posts/1' => 2,
      }
    end
  end

  it 'should not aggregate nil values' do
    prev_totals, prev_uniques = aggregator.pageviews

    expect do
      aggregator.aggregate(nil, nil)
      aggregator.aggregate(nil, nil)
    end.to_not(raise_error)

    totals, uniques = aggregator.pageviews
    expect(totals).to(eq(prev_totals))
    expect(uniques).to(eq(prev_uniques))
  end
end
