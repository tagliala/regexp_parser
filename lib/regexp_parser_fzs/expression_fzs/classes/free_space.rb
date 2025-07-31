# frozen_string_literal: true

module Regexp::ExpressionFzs
  class FreeSpace < Regexp::ExpressionFzs::Base
    def quantify(*_args)
      raise Regexp::ParserFzs::Error, 'Can not quantify a free space object'
    end
  end

  class Comment < Regexp::ExpressionFzs::FreeSpace
  end

  class WhiteSpace < Regexp::ExpressionFzs::FreeSpace
    def merge(exp)
      warn("#{self.class}##{__method__} is deprecated and will be removed in v3.0.0.")
      text << exp.text
    end
  end
end
