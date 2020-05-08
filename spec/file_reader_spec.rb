# frozen_string_literal: true

describe LogParser::FileReader do
  let(:reader) { LogParser::FileReader.new }

  describe '.read' do
    it 'should raise if file does not exist' do
      expect do
        reader.read('wrongfile.log')
      end.to(raise_error(LogParser::FileReader::FileNotFound))
    end

    it 'should raise if invalid filename' do
      expect do
        reader.read(nil)
      end.to(raise_error(LogParser::FileReader::InvalidFilename))
    end

    it 'should stream lines from file' do
      read_lines = []
      reader.read('./spec/fixtures/file_reader_1.log') do |line|
        read_lines << line
      end

      expect(read_lines).to(eq([
        'This is line1',
        'This is line2 /with-an-url',
        'This is line3 /and-a-number 3',
      ]))
    end
  end
end
