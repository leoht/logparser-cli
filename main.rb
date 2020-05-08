#!/bin/ruby
# frozen_string_literal: true
require './lib/log_parser.rb'
require './lib/application.rb'

service = LogParser::Service.new(
  LogParser::FileReader.new,
  LogParser::LineParser.new,
  LogParser::PageviewsAggregator.new
)
presenter = LogParser::ConsolePresenter.new

Application.new(service, presenter).run
