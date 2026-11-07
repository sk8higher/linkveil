# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Linkveil::Sanitizers::Instagram do
  describe '.clean' do
    {
      'igsh' => 'secret',
      'igshid' => 'secret',
      'igsi' => 'secret',
      'stkn' => 'secret',
      'utm_source' => 'ig_web_copy_link',
      'utm_medium' => 'copy_link'
    }.each do |param, value|
      it "removes #{param}" do
        uri = URI.parse(
          "https://www.instagram.com/reel/abc123/?#{param}=#{value}"
        )

        expect(described_class.clean(uri)).to eq(
          'https://www.instagram.com/reel/abc123/'
        )
      end
    end

    it 'preserves functional parameters' do
      uri = URI.parse(
        'https://www.instagram.com/p/abc123/?igsh=secret&img_index=2'
      )

      expect(described_class.clean(uri)).to eq(
        'https://www.instagram.com/p/abc123/?img_index=2'
      )
    end

    it 'preserves URLs without tracking parameters' do
      uri = URI.parse(
        'https://www.instagram.com/username/'
      )

      expect(described_class.clean(uri)).to eq(
        'https://www.instagram.com/username/'
      )
    end
  end

  describe 'registration' do
    it 'registers itself in the sanitizer registry' do
      expect(Linkveil::Sanitizer.registry).to include(described_class)
    end

    it 'matches Instagram domains' do
      expect(Linkveil::Sanitizer.find_for('instagram.com'))
        .to eq(described_class)

      expect(Linkveil::Sanitizer.find_for('www.instagram.com'))
        .to eq(described_class)
    end

    it 'does not match unrelated domains' do
      expect(Linkveil::Sanitizer.find_for('fakeinstagram.com'))
        .not_to eq(described_class)
    end
  end
end
