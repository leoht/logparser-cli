# frozen_string_literal: true
class Application
  def initialize(service, presenter)
    @service = service
    @presenter = presenter
  end

  def run
    filepath = ARGV.first

    begin
      pageviews_response = @service.parse_and_aggregate_logs(filepath)
      print(@presenter.render(pageviews_response))
    rescue LogParser::FileReader::InvalidFilename
      puts "\n\tInvalid filename!\n"
    rescue LogParser::FileReader::FileNotFound
      puts "\n\tFile not found!\n"
    end
  end
end
