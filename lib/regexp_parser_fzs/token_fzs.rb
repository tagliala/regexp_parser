# frozen_string_literal: true

class Regexp
  TOKEN_KEYS_FZS = %i[
    type
    token
    text
    ts
    te
    level
    set_level
    conditional_level
  ].freeze

  TokenFzs = Struct.new(*TOKEN_KEYS_FZS) do
    attr_accessor :previous, :next

    def offset
      [ts, te]
    end

    def length
      te - ts
    end
  end
end
