# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(Regexp::SyntaxFzs::V2_2_0) do
  include_examples 'syntax',
  implements: {
    property: T::UnicodeProperty::Script_V2_2_0 + T::UnicodeProperty::Age_V2_2_0,
    nonproperty: T::UnicodeProperty::Script_V2_2_0 + T::UnicodeProperty::Age_V2_2_0
  }
end
