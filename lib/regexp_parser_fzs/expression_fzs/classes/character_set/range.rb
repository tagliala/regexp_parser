# frozen_string_literal: true

module Regexp::ExpressionFzs
  class CharacterSet < Regexp::ExpressionFzs::Subexpression
    class Range < Regexp::ExpressionFzs::Subexpression
      def ts
        (head = expressions.first) ? head.ts : @ts
      end

      def <<(exp)
        complete? and raise Regexp::ParserFzs::Error,
          "Can't add more than 2 expressions to a Range"
        super
      end

      def complete?
        count == 2
      end
    end
  end
end
