# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(Regexp::SyntaxFzs) do
  describe('::for') do
    it { expect(Regexp::SyntaxFzs.for('ruby/1.8.6')).to eq  Regexp::SyntaxFzs::V1_8_6 }
    it { expect(Regexp::SyntaxFzs.for('ruby/1.8')).to eq    Regexp::SyntaxFzs::V1_8_6 }
    it { expect(Regexp::SyntaxFzs.for('ruby/1.9.1')).to eq  Regexp::SyntaxFzs::V1_9_1 }
    it { expect(Regexp::SyntaxFzs.for('ruby/1.9')).to eq    Regexp::SyntaxFzs::V1_9_3 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.0.0')).to eq  Regexp::SyntaxFzs::V2_0_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.0')).to eq    Regexp::SyntaxFzs::V2_0_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.1')).to eq    Regexp::SyntaxFzs::V2_0_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.2.0')).to eq  Regexp::SyntaxFzs::V2_2_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.2.10')).to eq Regexp::SyntaxFzs::V2_2_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.2')).to eq    Regexp::SyntaxFzs::V2_2_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.3.0')).to eq  Regexp::SyntaxFzs::V2_3_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.3')).to eq    Regexp::SyntaxFzs::V2_3_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.4.0')).to eq  Regexp::SyntaxFzs::V2_4_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.4.1')).to eq  Regexp::SyntaxFzs::V2_4_1 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.5.0')).to eq  Regexp::SyntaxFzs::V2_5_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.5')).to eq    Regexp::SyntaxFzs::V2_5_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.6.0')).to eq  Regexp::SyntaxFzs::V2_6_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.6.2')).to eq  Regexp::SyntaxFzs::V2_6_2 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.6.3')).to eq  Regexp::SyntaxFzs::V2_6_3 }
    it { expect(Regexp::SyntaxFzs.for('ruby/2.6')).to eq    Regexp::SyntaxFzs::V2_6_3 }
    it { expect(Regexp::SyntaxFzs.for('ruby/3.0.0')).to eq  Regexp::SyntaxFzs::V2_6_3 }
    it { expect(Regexp::SyntaxFzs.for('ruby/3.0')).to eq    Regexp::SyntaxFzs::V2_6_3 }
    it { expect(Regexp::SyntaxFzs.for('ruby/3.1.0')).to eq  Regexp::SyntaxFzs::V3_1_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/3.1')).to eq    Regexp::SyntaxFzs::V3_1_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/3.2.0')).to eq  Regexp::SyntaxFzs::V3_2_0 }
    it { expect(Regexp::SyntaxFzs.for('ruby/3.2')).to eq    Regexp::SyntaxFzs::V3_2_0 }

    it { expect(Regexp::SyntaxFzs.for('any')).to eq         Regexp::SyntaxFzs::Any }
    it { expect(Regexp::SyntaxFzs.for('*')).to eq           Regexp::SyntaxFzs::Any }

    it 'raises for unknown names' do
      expect { Regexp::SyntaxFzs.for('ruby/1.0') }.to raise_error(Regexp::SyntaxFzs::UnknownSyntaxNameError)
    end

    it 'raises for invalid names' do
      expect { Regexp::SyntaxFzs.version_class('2.0.0') }.to raise_error(Regexp::SyntaxFzs::InvalidVersionNameError)
      expect { Regexp::SyntaxFzs.version_class('ruby/20') }.to raise_error(Regexp::SyntaxFzs::InvalidVersionNameError)
    end
  end

  specify('::new is a deprecated alias of ::for') do
    expect { expect(Regexp::SyntaxFzs.new('ruby/2.0.0')).to eq Regexp::SyntaxFzs::V2_0_0 }
      .to output(/deprecated/).to_stderr
  end

  specify('not implemented') do
    expect { RP.parse('\p{alpha}', 'ruby/1.8') }.to raise_error(Regexp::SyntaxFzs::NotImplementedError)
  end

  specify('supported?') do
    expect(Regexp::SyntaxFzs.supported?('ruby/1.1.1')).to be false
    expect(Regexp::SyntaxFzs.supported?('ruby/2.4.3')).to be true
    expect(Regexp::SyntaxFzs.supported?('ruby/2.5')).to be true
  end

  specify('raises for unknown constant lookups') do
    expect { Regexp::SyntaxFzs::V1 }.to raise_error(/V1/)
  end

  specify('instantiation is deprecated but still works') do
    expect { @instance = Regexp::SyntaxFzs::V3_1_0.new }
      .to output(/deprecated/).to_stderr
    expect { expect(@instance.implements?(:literal, :literal)).to be true }
      .to output(/deprecated/).to_stderr
  end
end
