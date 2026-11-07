# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Linkveil do
  describe '.clean' do
    context 'with YouTube URLs' do
      it 'removes sharing identifiers' do
        url = 'https://youtu.be/abc123?si=secret123'

        expect(described_class.clean(url)).to eq(
          'https://youtu.be/abc123'
        )
      end

      it 'preserves video timestamps' do
        url = 'https://youtu.be/abc123?si=secret123&t=120'

        expect(described_class.clean(url)).to eq(
          'https://youtu.be/abc123?t=120'
        )
      end

      it 'preserves video IDs in query parameters' do
        url = 'https://www.youtube.com/watch?v=abc123&si=secret123'

        expect(described_class.clean(url)).to eq(
          'https://www.youtube.com/watch?v=abc123'
        )
      end

      it 'cleans Spotify URLs' do
        url = 'https://open.spotify.com/track/abc123?si=secret'

        expect(Linkveil.clean(url)).to eq(
          'https://open.spotify.com/track/abc123'
        )
      end
    end

    context 'with Instagram URLs' do
      it 'cleans Instagram URLs' do
        url = 'https://www.instagram.com/reel/abc/?igsh=secret&img_index=2'

        expect(described_class.clean(url)).to eq(
          'https://www.instagram.com/reel/abc/?img_index=2'
        )
      end

      it 'preserves unrelated domains' do
        url = 'https://fakeinstagram.com/p/abc/?igsh=secret'

        expect(described_class.clean(url)).to eq(url)
      end

      it 'preserves the fragment and functional parameters' do
        url = 'https://www.instagram.com/p/abc/?img_index=2&igsh=secret#comments'

        expect(Linkveil.clean(url)).to eq(
          'https://www.instagram.com/p/abc/?img_index=2#comments'
        )
      end
    end
  end
end
