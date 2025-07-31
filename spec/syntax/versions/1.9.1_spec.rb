# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(Regexp::SyntaxFzs::V1_9_1) do
  include_examples 'syntax',
  implements: {
    escape: T::Escape::Hex + T::Escape::Octal + T::Escape::Unicode,
    type: T::CharacterType::Hex,
    quantifier: T::Quantifier::Greedy + T::Quantifier::Reluctant + T::Quantifier::Possessive
  }
end
