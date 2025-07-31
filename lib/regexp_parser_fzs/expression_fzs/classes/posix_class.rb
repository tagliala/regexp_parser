# frozen_string_literal: true

module Regexp::ExpressionFzs
  class PosixClass < Regexp::ExpressionFzs::Base
    def name
      text[/\w+/]
    end
  end

  # alias for symmetry between token symbol and Expression class name
  Posixclass    = PosixClass
  Nonposixclass = PosixClass
end
