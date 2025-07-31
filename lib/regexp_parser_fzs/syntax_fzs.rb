# frozen_string_literal: true

require_relative 'error'

module Regexp::SyntaxFzs
  class SyntaxError < Regexp::ParserFzs::Error; end
end

require_relative 'syntax_fzs/token'
require_relative 'syntax_fzs/base'
require_relative 'syntax_fzs/any'
require_relative 'syntax_fzs/version_lookup'
require_relative 'syntax_fzs/versions'
