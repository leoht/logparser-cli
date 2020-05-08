#!/bin/ruby
# frozen_string_literal: true
require './lib/log_parser.rb'

filepath = ARGV.first

parser = LogParser::Service.new(
  LogParser::FileReader.new,
  LogParser::LineParser.new,
  LogParser::PageviewsAggregator.new
)

begin
  pageviews_response = parser.parse_and_aggregate_logs(filepath)
  print(LogParser::ConsolePresenter.new(pageviews_response).render)
rescue LogParser::FileReader::InvalidFilename
  # error
rescue LogParser::FileReader::FileNotFound
  # error
end
