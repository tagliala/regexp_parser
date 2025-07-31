# frozen_string_literal: true

require 'benchmark/ips'
require 'benchmark/memory'
require 'regexp_parser'
require_relative '../../lib/regexp_parser_fzs'

puts 'Scanner'

require 'uri'
regexp = URI::DEFAULT_PARSER.make_regexp

%i[ips memory].each do |benchmark|
  Benchmark.send(benchmark) do |x|
    x.report('Scanner::scan')       { Regexp::Scanner.scan(regexp) }
    x.report('Scanner::scan (FZS)') { Regexp::ScannerFzs.scan(regexp) }

    x.compare!
  end
end
