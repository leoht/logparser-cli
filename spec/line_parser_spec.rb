# frozen_string_literal: true
describe LogParser::LineParser do
  let(:parser) { LogParser::LineParser.new }

  it 'should parse path and IPv6 from line' do
    line = '/about 2001:0db8:85a3:0000:0000:8a2e:0370:7334'
    expect(
      parser.parse(line)
    ).to(eq(['/about', '2001:0db8:85a3:0000:0000:8a2e:0370:7334']))
  end

  it 'should parse path and IPv4 from line' do
    line = '/about 172.38.48.120'
    expect(
      parser.parse(line)
    ).to(eq(['/about', '172.38.48.120']))
  end

  it 'should ignore invalid line' do
    line = '/about 10 0 0'
    expect(
      parser.parse(line)
    ).to(eq(nil))
  end

  it 'should ignore line with invalid ip address' do
    line = '/about 1.324.234.500'
    expect(
      parser.parse(line)
    ).to(eq(nil))
  end

  it 'should ignore line with another invalid ip address' do
    line = '/about 1.324.bd.500'
    expect(
      parser.parse(line)
    ).to(eq(nil))
  end

  it 'should ignore empty line' do
    line = ''
    expect(
      parser.parse(line)
    ).to(eq(nil))
  end
end
