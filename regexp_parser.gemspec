# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{regexp_parser}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ammar Ali"]
  s.date = %q{2010-10-01}
  s.description = %q{Scanner, lexer, parser for ruby's regular expressions}
  s.email = %q{ammarabuali@gmail.com}
  s.extra_rdoc_files = [
    "ChangeLog",
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "ChangeLog",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/regexp_parser.rb",
    "lib/regexp_parser/ctype.rb",
    "lib/regexp_parser/expression.rb",
    "lib/regexp_parser/expression/property.rb",
    "lib/regexp_parser/expression/set.rb",
    "lib/regexp_parser/lexer.rb",
    "lib/regexp_parser/parser.rb",
    "lib/regexp_parser/scanner.rb",
    "lib/regexp_parser/scanner/property.rl",
    "lib/regexp_parser/scanner/scanner.rl",
    "lib/regexp_parser/syntax.rb",
    "lib/regexp_parser/syntax/ruby/1.8.6.rb",
    "lib/regexp_parser/syntax/ruby/1.8.7.rb",
    "lib/regexp_parser/syntax/ruby/1.8.rb",
    "lib/regexp_parser/syntax/ruby/1.9.1.rb",
    "lib/regexp_parser/syntax/ruby/1.9.2.rb",
    "lib/regexp_parser/syntax/ruby/1.9.3.rb",
    "lib/regexp_parser/syntax/ruby/1.9.rb",
    "lib/regexp_parser/syntax/tokens.rb",
    "regexp_parser.gemspec",
    "test/helpers.rb",
    "test/lexer/test_all.rb",
    "test/lexer/test_literals.rb",
    "test/lexer/test_nesting.rb",
    "test/lexer/test_refcalls.rb",
    "test/parser/test_all.rb",
    "test/parser/test_alternation.rb",
    "test/parser/test_anchors.rb",
    "test/parser/test_errors.rb",
    "test/parser/test_escapes.rb",
    "test/parser/test_expression.rb",
    "test/parser/test_groups.rb",
    "test/parser/test_properties.rb",
    "test/parser/test_quantifiers.rb",
    "test/parser/test_refcalls.rb",
    "test/parser/test_sets.rb",
    "test/scanner/test_all.rb",
    "test/scanner/test_anchors.rb",
    "test/scanner/test_errors.rb",
    "test/scanner/test_escapes.rb",
    "test/scanner/test_groups.rb",
    "test/scanner/test_literals.rb",
    "test/scanner/test_meta.rb",
    "test/scanner/test_properties.rb",
    "test/scanner/test_quantifiers.rb",
    "test/scanner/test_refcalls.rb",
    "test/scanner/test_scripts.rb",
    "test/scanner/test_sets.rb",
    "test/scanner/test_types.rb",
    "test/syntax/ruby/test_1.8.rb",
    "test/syntax/ruby/test_1.9.1.rb",
    "test/syntax/ruby/test_1.9.3.rb",
    "test/syntax/ruby/test_all.rb",
    "test/syntax/test_all.rb",
    "test/test_all.rb"
  ]
  s.homepage = %q{http://github.com/ammar/regexp_parser}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A library for tokenizing, lexing, and parsing Ruby regular expressions.}
  s.test_files = [
    "test/helpers.rb",
    "test/lexer/test_all.rb",
    "test/lexer/test_literals.rb",
    "test/lexer/test_nesting.rb",
    "test/lexer/test_refcalls.rb",
    "test/parser/test_all.rb",
    "test/parser/test_alternation.rb",
    "test/parser/test_anchors.rb",
    "test/parser/test_errors.rb",
    "test/parser/test_escapes.rb",
    "test/parser/test_expression.rb",
    "test/parser/test_groups.rb",
    "test/parser/test_properties.rb",
    "test/parser/test_quantifiers.rb",
    "test/parser/test_refcalls.rb",
    "test/parser/test_sets.rb",
    "test/scanner/test_all.rb",
    "test/scanner/test_anchors.rb",
    "test/scanner/test_errors.rb",
    "test/scanner/test_escapes.rb",
    "test/scanner/test_groups.rb",
    "test/scanner/test_literals.rb",
    "test/scanner/test_meta.rb",
    "test/scanner/test_properties.rb",
    "test/scanner/test_quantifiers.rb",
    "test/scanner/test_refcalls.rb",
    "test/scanner/test_scripts.rb",
    "test/scanner/test_sets.rb",
    "test/scanner/test_types.rb",
    "test/syntax/ruby/test_1.8.rb",
    "test/syntax/ruby/test_1.9.1.rb",
    "test/syntax/ruby/test_1.9.3.rb",
    "test/syntax/ruby/test_all.rb",
    "test/syntax/test_all.rb",
    "test/test_all.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

