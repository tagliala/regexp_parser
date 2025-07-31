# frozen_string_literal: true

module Regexp::ExpressionFzs
  # A sequence of expressions, used by Alternation as one of its alternatives.
  class Alternative < Regexp::ExpressionFzs::Sequence; end

  class Alternation < Regexp::ExpressionFzs::SequenceOperation
    OPERAND = Alternative

    alias :alternatives :expressions
  end
end
