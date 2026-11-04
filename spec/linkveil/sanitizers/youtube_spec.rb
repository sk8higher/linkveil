# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Linkveil::Sanitizers::YouTube do
  describe '.clean' do
    it 'removes tracking parameters but preserves timestamps' do
      uri = URI.parse(
        'https://youtu.be/abc123?si=secret&feature=shared&t=120'
      )

      expect(described_class.clean(uri)).to eq(
        'https://youtu.be/abc123?t=120'
      )
    end
  end
end
