# frozen_string_literal: true

require "tempfile"
require "benchmark/ips"
require "gem_bench/jersey"
require "uri"
require "json"

# Constants used for temp file paths necessary to separate gem namespaces that would otherwise collide.
GITHUB_MAIN_NAMESPACE = "RegexpParserGitHubMain"
GITHUB_MAIN_BENCHMARK_NAME = "regexp_parser-github-main"
LOCAL_BENCHMARK_NAME = "regexp_parser-local"

# 1. The GitHub version of regexp_parser and the local source of regexp_parser share the same namespace.
# This means we must use `require: false` in the `benchmarks/Gemfile` for the git version
# to avoid a namespace collision before we can rename the constants.
re_namespaced_gem = GemBench::Jersey.new(
  gem_name: "regexp_parser",
  trades: {
    "Regexp" => GITHUB_MAIN_NAMESPACE
  },
  verbose: true
)
re_namespaced_gem.doff_and_don # Copies, re-namespaces, and requires the gem.

# We've already installed the `regexp_parser` version from the `main` branch on GitHub,
# moved it into a temporary directory, and re-namespaced it. Now, we require the local
# version of `regexp_parser` to compare this branch against it.
require_relative "../lib/regexp_parser"

class BenchmarkSuiteWithoutGC
  def warming(*)
    run_gc
  end

  def running(*)
    run_gc
  end

  def warmup_stats(*); end
  def add_report(*); end

  private

  def run_gc
    GC.enable
    GC.start
    GC.disable
  end
end
suite = BenchmarkSuiteWithoutGC.new

BenchmarkGem = Struct.new(:klass, :name) do
  def benchmark_name
    "#{name} (#{klass::VERSION})"
  end
end

BENCHMARK_GEMS = [
  BenchmarkGem.new(
    Object.const_get(GITHUB_MAIN_NAMESPACE),
    GITHUB_MAIN_BENCHMARK_NAME
  ),
  BenchmarkGem.new(
    Regexp,
    LOCAL_BENCHMARK_NAME
  )
].shuffle

puts "\nWill BENCHMARK_GEMS:\n\t#{BENCHMARK_GEMS.map(&:benchmark_name).join("\n\t")}\n"

regexp_to_parse = URI::DEFAULT_PARSER.make_regexp

benchmark_lambdas = [
  lambda do |x, benchmark_gem|
    x.report("#{benchmark_gem.benchmark_name}: Scanner::scan") do
      benchmark_gem.klass::Scanner.scan(regexp_to_parse)
    end
  end,
  lambda do |x, benchmark_gem|
    x.report("#{benchmark_gem.benchmark_name}: Lexer::lex") do
      benchmark_gem.klass::Lexer.lex(regexp_to_parse)
    end
  end,
  lambda do |x, benchmark_gem|
    x.report("#{benchmark_gem.benchmark_name}: Parser::parse") do
      benchmark_gem.klass::Parser.parse(regexp_to_parse)
    end
  end
]

N_RESULT_DECIMAL_DIGITS = 2

benchmark_jsons = benchmark_lambdas.map do |benchmark|
  json_file = Tempfile.new

  Benchmark.ips do |x|
    x.config(suite: suite)
    BENCHMARK_GEMS.each do |benchmark_gem|
      benchmark.call(x, benchmark_gem)
    end

    x.compare!
    x.json! json_file.path
  end

  JSON.parse(json_file.read)
ensure
  json_file.close
  json_file.unlink
end

[true, false].each do |github_comparison|
  puts "### Comparison against #{github_comparison ? 'GitHub main' : 'Other Gems'}"
  benchmark_jsons.each_with_index do |benchmark_json, i|
    local_regexp_parser = benchmark_json.find { |json| json["name"].start_with?(LOCAL_BENCHMARK_NAME) }
    benchmark_json -= [local_regexp_parser]

    github_main = benchmark_json.find { |json| json["name"].start_with?(GITHUB_MAIN_BENCHMARK_NAME) }
    benchmark_json = github_comparison ? [github_main].compact : benchmark_json - [github_main].compact

    next if benchmark_json.empty?

    benchmark_json.sort_by! { |json| json["name"] }

    if i == 0
      benchmark_headers = benchmark_json.map do |benchmark_gem|
        gem_name_parts = benchmark_gem["name"].split
        # Correctly format the header, e.g., `regexp_parser-github-main` (2.1.1)
        "`#{gem_name_parts[0]}` #{gem_name_parts[1]}"
      end.join("|")
      puts "|Benchmark|#{benchmark_headers}|"
      puts "|#{'--|' * (benchmark_json.size + 1)}"
    end

    output_str = benchmark_json.map do |bgem|
      ratio = local_regexp_parser["central_tendency"] / bgem["central_tendency"]
      "%.#{N_RESULT_DECIMAL_DIGITS}fx" % ratio.round(N_RESULT_DECIMAL_DIGITS)
    end.join("|")

    # Extracts the benchmark name, e.g., "Scanner::scan"
    name = local_regexp_parser["name"].partition(": ").last
    puts "|`#{name}`|#{output_str}|"
  end
  puts ""
end
