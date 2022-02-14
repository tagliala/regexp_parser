module Regexp::Syntax
  # use the last 1.9 release as the base
  class V2_0_0 < Regexp::Syntax::V1_9
    implements :keep,        Keep::All
    implements :conditional, Conditional::All
    implements :property,    UnicodeProperty::V2_0_0
    implements :nonproperty, UnicodeProperty::V2_0_0
    implements :type,        CharacterType::Clustered

    excludes   :property,    %i[newline]
    excludes   :nonproperty, %i[newline]
  end
end
