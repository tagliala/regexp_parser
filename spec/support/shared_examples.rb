# frozen_string_literal: true

RSpec.shared_examples 'syntax' do |opts|
  opts[:implements].each do |type, tokens|
    tokens.each do |token|
      it("implements #{token} #{type}") do
        expect(described_class.implements?(type, token)).to be true
      end
    end
  end

  opts[:excludes] && opts[:excludes].each do |type, tokens|
    tokens.each do |token|
      it("does not implement #{token} #{type}") do
        expect(described_class.implements?(type, token)).to be false
      end
    end
  end
end

RSpec.shared_examples 'scan' do |pattern, checks|
  context "given the pattern #{pattern}" do
    before(:all) { @tokens = Regexp::ScannerFzs.scan(pattern) }

    checks.each do |index, (type, token, text, ts, te)|
      it "scans token #{index} as #{token} #{type} at #{ts}..#{te}" do
        result = @tokens.at(index)
        result || fail("no token at index #{index}, max is #{@tokens.size - 1}")

        expect(result[0]).to eq type
        expect(result[1]).to eq token
        expect(result[2]).to eq text
        expect(result[3]).to eq ts
        expect(result[4]).to eq te
      end
    end
  end
end

RSpec.shared_examples 'lex' do |pattern, checks|
  context "given the pattern #{pattern}" do
    before(:all) { @tokens = Regexp::LexerFzs.lex(pattern) }

    checks.each do |index, (type, token, text, ts, te, lvl, set_lvl, cond_lvl)|
      it "lexes token #{index} as #{token} #{type} at #{lvl}, #{set_lvl}, #{cond_lvl}" do
        struct = @tokens.at(index)

        expect(struct.type).to eq type
        expect(struct.token).to eq token
        expect(struct.text).to eq text
        expect(struct.ts).to eq ts
        expect(struct.te).to eq te
        expect(struct.level).to eq lvl
        expect(struct.set_level).to eq set_lvl
        expect(struct.conditional_level).to eq cond_lvl
      end
    end
  end
end

RSpec.shared_examples 'parse' do |pattern, checks|
  context "given the pattern #{pattern}" do
    before(:all) { @root = Regexp::ParserFzs.parse(pattern, '*') }

    checks.each do |path, expectations|
      path = Array(path)
      inspect_quantifier = path.last == :q && path.pop

      attributes = expectations.pop if expectations.last.is_a?(Hash)
      klass      = expectations.pop if expectations.last.is_a?(Class)
      token      = expectations.pop
      type       = expectations.pop

      description = klass || token || type || 'Expression'

      it "parses expression at #{path} as #{description}" do
        exp = @root.dig(*path)
        exp = exp.quantifier if inspect_quantifier

        klass && expect(exp).to(be_instance_of(klass))
        type  && expect(exp.type).to(eq(type))
        token && expect(exp.token).to(eq(token))

        attributes && attributes.each do |method, value|
          actual = exp.send(method)
          expect(actual).to eq(value),
            "expected #{description} at #{path} to "\
            "have #{method} #{value.inspect}, got #{actual.inspect}"
        end
      end
    end
  end
end
