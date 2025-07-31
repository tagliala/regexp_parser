# frozen_string_literal: true

require 'benchmark/ips'
require 'benchmark/memory'
require 'regexp_parser'
require_relative '../../lib/regexp_parser_fzs'

puts 'Lexer'

require 'uri'
regexp = URI::DEFAULT_PARSER.make_regexp

%i[ips memory].each do |benchmark|
  Benchmark.send(benchmark) do |x|
    x.report('Lexer::lex')       { Regexp::Lexer.lex(regexp)    }
    x.report('Lexer::lex (FZS)') { Regexp::LexerFzs.lex(regexp) }

    x.compare!
  end
end
