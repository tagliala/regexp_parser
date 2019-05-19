require 'spec_helper'

RSpec.describe(Regexp::Scanner) do
  RSpec.shared_examples 'scan error' do |error, issue, source|
    it "raises #{error} for #{issue}" do
      expect { RS.scan(source) }.to raise_error(error)
    end
  end

  include_examples 'scan error', RS::PrematureEndError, 'unbalanced set', '[a'
  include_examples 'scan error', RS::PrematureEndError, 'unbalanced set', '[[:alpha:]'
  include_examples 'scan error', RS::PrematureEndError, 'unbalanced group', '(abc'
  include_examples 'scan error', RS::PrematureEndError, 'unbalanced interval', 'a{1,2'
  include_examples 'scan error', RS::PrematureEndError, 'eof in property', '\p{asci'
  include_examples 'scan error', RS::PrematureEndError, 'incomplete property', '\p{ascii abc'
  include_examples 'scan error', RS::PrematureEndError, 'eof options', '(?mix'
  include_examples 'scan error', RS::PrematureEndError, 'eof escape', '\\'
  include_examples 'scan error', RS::PrematureEndError, 'eof in hex escape', '\x'
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u'
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u0'
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u00'
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u000'
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u{'
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u{00'
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u{0000'
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u{0000 '
  include_examples 'scan error', RS::PrematureEndError, 'eof in cp escape', '\u{0000 0000'
  include_examples 'scan error', RS::PrematureEndError, 'eof in c-seq', '\c'
  include_examples 'scan error', RS::PrematureEndError, 'eof in c-seq', '\c\\M'
  include_examples 'scan error', RS::PrematureEndError, 'eof in c-seq', '\c\\M-'
  include_examples 'scan error', RS::PrematureEndError, 'eof in c-seq', '\C'
  include_examples 'scan error', RS::PrematureEndError, 'eof in c-seq', '\C-'
  include_examples 'scan error', RS::PrematureEndError, 'eof in c-seq', '\C-\\M'
  include_examples 'scan error', RS::PrematureEndError, 'eof in c-seq', '\C-\\M-'
  include_examples 'scan error', RS::PrematureEndError, 'eof in m-seq', '\M'
  include_examples 'scan error', RS::PrematureEndError, 'eof in m-seq', '\M-'
  include_examples 'scan error', RS::PrematureEndError, 'eof in m-seq', '\M-\\'
  include_examples 'scan error', RS::PrematureEndError, 'eof in m-seq', '\M-\\c'
  include_examples 'scan error', RS::PrematureEndError, 'eof in m-seq', '\M-\\C'
  include_examples 'scan error', RS::PrematureEndError, 'eof in m-seq', '\M-\\C-'
  include_examples 'scan error', RS::InvalidSequenceError, 'invalid hex', '\xZ'
  include_examples 'scan error', RS::InvalidSequenceError, 'invalid hex', '\xZ0'
  include_examples 'scan error', RS::InvalidGroupError, 'invalid group', "(?'')"
  include_examples 'scan error', RS::InvalidGroupError, 'invalid group', "(?''empty-name)"
  include_examples 'scan error', RS::InvalidGroupError, 'invalid group', '(?<>)'
  include_examples 'scan error', RS::InvalidGroupError, 'invalid group', '(?<>empty-name)'
  include_examples 'scan error', RS::InvalidGroupOption, 'invalid option', '(?foo)'
  include_examples 'scan error', RS::InvalidGroupOption, 'invalid option', '(?mix abc)'
  include_examples 'scan error', RS::InvalidGroupOption, 'invalid option', '(?mix^bc'
  include_examples 'scan error', RS::InvalidGroupOption, 'invalid option', '(?)'
  include_examples 'scan error', RS::InvalidGroupOption, 'invalid neg option', '(?-foo)'
  include_examples 'scan error', RS::InvalidGroupOption, 'invalid neg option', '(?-u)'
  include_examples 'scan error', RS::InvalidGroupOption, 'invalid neg option', '(?-mixu)'
  include_examples 'scan error', RS::InvalidBackrefError, 'empty backref', '\k<>'
  include_examples 'scan error', RS::InvalidBackrefError, 'empty backref', '\k\'\''
  include_examples 'scan error', RS::InvalidBackrefError, 'empty refcall', '\g<>'
  include_examples 'scan error', RS::InvalidBackrefError, 'empty refcall', '\g\'\''
  include_examples 'scan error', RS::UnknownUnicodePropertyError, 'unknown property', '\p{foobar}'
end
