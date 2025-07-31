#!/usr/bin/env ruby -s
# frozen_string_literal: true

require_relative 'lib/regexp_parser'
require 'benchmark'

require 'uri'
regexp = URI::DEFAULT_PARSER.make_regexp

TIMES = 500

puts RUBY_DESCRIPTION

Benchmark.bmbm(30) do |x|
  x.report('Scanner::scan') { TIMES.times { Regexp::Scanner.scan(regexp) } }
  x.report('Lexer::lex')    { TIMES.times { Regexp::Lexer.lex(regexp)    } }
  x.report('Parser::parse') { TIMES.times { Regexp::Parser.parse(regexp) } }
end
