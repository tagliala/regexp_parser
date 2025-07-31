# frozen_string_literal: true

module Regexp::ExpressionFzs
  # abstract class
  class SequenceOperation < Regexp::ExpressionFzs::Subexpression
    alias :sequences :expressions
    alias :operands :expressions
    alias :operator :text

    def ts
      (head = expressions.first) ? head.ts : @ts
    end

    def <<(exp)
      expressions.last << exp
    end

    def add_sequence(active_opts = {}, params = { ts: 0 })
      self.class::OPERAND.add_to(self, params, active_opts)
    end
  end
end
