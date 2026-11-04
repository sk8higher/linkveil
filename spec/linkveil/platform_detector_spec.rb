# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Linkveil::PlatformDetector do
  describe '.detect' do
    it 'detects YouTube' do
      expect(described_class.detect('youtu.be')).to eq(:youtube)
      expect(described_class.detect('www.youtube.com')).to eq(:youtube)
      expect(described_class.detect('m.youtube.com')).to eq(:youtube)
    end

    it 'detects TikTok' do
      expect(described_class.detect('www.tiktok.com')).to eq(:tiktok)
      expect(described_class.detect('vm.tiktok.com')).to eq(:tiktok)
    end

    it 'detects Spotify' do
      expect(described_class.detect('open.spotify.com')).to eq(:spotify)
    end

    it 'returns nil for unknown platforms' do
      expect(described_class.detect('example.com')).to be_nil
    end

    it 'does not match lookalike domains' do
      expect(described_class.detect('fake-youtube.com')).to be_nil
      expect(described_class.detect('youtube.com.evil.com')).to be_nil
    end

    it 'handles nil host' do
      expect(described_class.detect(nil)).to be_nil
    end

    it 'handles uppercase hostnames' do
      expect(described_class.detect('WWW.YOUTUBE.COM')).to eq(:youtube)
    end
  end
end
