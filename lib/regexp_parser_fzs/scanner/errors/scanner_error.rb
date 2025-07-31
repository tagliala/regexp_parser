# frozen_string_literal: true

require_relative '../../../regexp_parser_fzs/error'

class Regexp::ScannerFzs
  # General scanner error (catch all)
  class ScannerError < Regexp::ParserFzs::Error; end
end
