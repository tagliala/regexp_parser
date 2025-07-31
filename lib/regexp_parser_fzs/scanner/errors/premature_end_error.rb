# frozen_string_literal: true

class Regexp::ScannerFzs
  # Unexpected end of pattern
  class PrematureEndError < ScannerError
    def initialize(where = '')
      super "Premature end of pattern at #{where}"
    end
  end
end
