# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(Regexp::SyntaxFzs::V2_0_0) do
  include_examples 'syntax',
  implements: {
    property: T::UnicodeProperty::Age_V2_0_0,
    nonproperty: T::UnicodeProperty::Age_V2_0_0
  },
  excludes: {
    property: %i[newline],
    nonproperty: %i[newline]
  }
end
