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
  end
end
