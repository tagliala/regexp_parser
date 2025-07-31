# frozen_string_literal: true

module Regexp::ExpressionFzs
  class CharacterSet < Regexp::ExpressionFzs::Subexpression
    class IntersectedSequence < Regexp::ExpressionFzs::Sequence; end

    class Intersection < Regexp::ExpressionFzs::SequenceOperation
      OPERAND = IntersectedSequence
    end
  end
end
