# frozen_string_literal: true

module Regexp::SyntaxFzs
  module Token
    module Virtual
      Root     = %i[root].freeze
      Sequence = %i[sequence].freeze

      All  = %i[root sequence].freeze
      Type = :expression
    end
  end
end
