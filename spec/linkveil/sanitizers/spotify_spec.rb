# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Linkveil::Sanitizers::Spotify do
  describe '.clean' do
    it 'removes sharing identifiers' do
      uri = URI.parse(
        'https://open.spotify.com/track/abc123?si=secret'
      )

      expect(described_class.clean(uri)).to eq(
        'https://open.spotify.com/track/abc123'
      )
    end
  end
end
