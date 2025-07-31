# frozen_string_literal: true

module Regexp::ExpressionFzs
  class Root < Regexp::ExpressionFzs::Subexpression
    def self.build(options = {})
      warn "`#{self.class}.build(options)` is deprecated and will raise in "\
           "regexp_parser v3.0.0. Please use `.construct(options: options)`."
      construct(options: options)
    end
  end
end
