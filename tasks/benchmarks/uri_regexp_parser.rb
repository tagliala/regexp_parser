# frozen_string_literal: true

require 'benchmark/ips'
require 'benchmark/memory'
require 'regexp_parser'
require_relative '../../lib/regexp_parser_fzs'

puts 'Parser'

require 'uri'
regexp = URI::DEFAULT_PARSER.make_regexp

%i[ips memory].each do |benchmark|
  Benchmark.send(benchmark) do |x|
    x.report('Parser::parse')       { Regexp::Parser.parse(regexp)    }
    x.report('Parser::parse (FZS)') { Regexp::ParserFzs.parse(regexp) }

    x.compare!
  end
end
