# frozen_string_literal: true

module Regexp::SyntaxFzs
  module Token
    module Keep
      Mark = %i[mark].freeze

      All  = Mark
      Type = :keep
    end

    Map[Keep::Type] = Keep::All
  end
end
