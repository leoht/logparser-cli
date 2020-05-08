# frozen_string_literal: true
describe LogParser::ConsolePresenter do
  let(:pageviews) do
    LogParser::Service::Response.new(
      {
        "/help_page/1" => 5,
        "/contact" => 3,
        "/about/2" => 3,
        "/home" => 2,
        "/index" => 1,
      },
      {
        "/help_page/1" => 4,
        "/contact" => 2,
        "/about/2" => 2,
        "/home" => 2,
        "/index" => 1,
      }
    )
  end
  let(:presenter) { LogParser::ConsolePresenter.new(pageviews) }

  it 'should render correctly' do
    expected = <<~EOF

######### Total pageviews #########

5\t\t/help_page/1
3\t\t/contact
3\t\t/about/2
2\t\t/home
1\t\t/index

######### Unique pageviews ########

4\t\t/help_page/1
2\t\t/contact
2\t\t/about/2
2\t\t/home
1\t\t/index
EOF

    expect(presenter.render).to(eq(expected))
  end
end
