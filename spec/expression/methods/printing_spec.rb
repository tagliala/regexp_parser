# frozen_string_literal: true

require 'spec_helper'

RSpec.describe('Expression::Shared#inspect') do
  it 'includes only essential information' do
    root = Regexp::ParserFzs.parse(//)
    expect(root.inspect).to eq '#<Regexp::ExpressionFzs::Root @expressions=[]>'

    root = Regexp::ParserFzs.parse(/(a)+/)
    expect(root.inspect)
      .to match(/#<Regexp::ExpressionFzs::Root @expressions=\[.+\]/)
    expect(root[0].inspect)
      .to match(/#<Regexp::ExpressionFzs::Group::Capture @text=.+ @quantifier=.+ @expressions=\[.+\]/)
    expect(root[0].quantifier.inspect)
      .to eq    '#<Regexp::ExpressionFzs::Quantifier @text="+">'
    expect(root[0][0].inspect)
      .to eq    '#<Regexp::ExpressionFzs::Literal @text="a">'
  end
end

RSpec.describe('Expression::Shared#pretty_print') do
  it 'works' do
    require 'pp'
    pp_to_s = ->(arg) { ''.dup.tap { |buffer| PP.new(buffer).pp(arg) } }

    root = Regexp::ParserFzs.parse(/(a)+/)

    expect(pp_to_s.(root)).to               start_with '#<Regexp::ExpressionFzs::Root'
    expect(pp_to_s.(root[0])).to            start_with '#<Regexp::ExpressionFzs::Group'
    expect(pp_to_s.(root[0].quantifier)).to start_with '#<Regexp::ExpressionFzs::Quantifier'
    expect(pp_to_s.(root[0][0])).to         start_with '#<Regexp::ExpressionFzs::Literal'
  end
end
