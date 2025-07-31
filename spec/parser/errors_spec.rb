# frozen_string_literal: true

require 'spec_helper'

RSpec.describe('Parsing errors') do
  let(:parser) { Regexp::ParserFzs.new }
  before { parser.parse(/foo/) } # initializes ivars

  it('raises UnknownTokenTypeError for unknown token types') do
    expect { parser.send(:parse_token, Regexp::TokenFzs.new(:foo, :bar)) }
      .to raise_error(Regexp::ParserFzs::UnknownTokenTypeError)
  end

  RSpec.shared_examples 'UnknownTokenError' do |type|
    it "raises for unknown tokens of type #{type}" do
      expect { parser.send(:parse_token, Regexp::TokenFzs.new(type, :foo)) }
        .to raise_error(Regexp::ParserFzs::UnknownTokenError)
    end
  end

  include_examples 'UnknownTokenError', :anchor
  include_examples 'UnknownTokenError', :backref
  include_examples 'UnknownTokenError', :conditional
  include_examples 'UnknownTokenError', :free_space
  include_examples 'UnknownTokenError', :group
  include_examples 'UnknownTokenError', :meta
  include_examples 'UnknownTokenError', :nonproperty
  include_examples 'UnknownTokenError', :property
  include_examples 'UnknownTokenError', :quantifier
  include_examples 'UnknownTokenError', :set
  include_examples 'UnknownTokenError', :type
end
