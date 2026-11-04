# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Linkveil::QueryCleaner do
  describe '.clean' do
    it 'removes specified parameters' do
      uri = URI.parse('https://example.com/?si=secret&t=120')

      result = described_class.clean(uri, remove: ['si'])

      expect(result).to eq('https://example.com/?t=120')
    end

    it 'removes multiple parameters' do
      uri = URI.parse('https://example.com/?si=secret&utm_source=share&t=120')

      result = described_class.clean(uri, remove: %w[si utm_source])

      expect(result).to eq('https://example.com/?t=120')
    end

    it 'removes the question mark when no parameters remain' do
      uri = URI.parse('https://example.com/?si=secret')

      expect(described_class.clean(uri, remove: ['si']))
        .to eq('https://example.com/')
    end

    it 'preserves URLs without query parameters' do
      uri = URI.parse('https://example.com/path')

      expect(described_class.clean(uri, remove: ['si']))
        .to eq('https://example.com/path')
    end

    it 'preserves repeated parameters that are not removed' do
      uri = URI.parse('https://example.com/?tag=a&tag=b&si=secret')

      expect(described_class.clean(uri, remove: ['si']))
        .to eq('https://example.com/?tag=a&tag=b')
    end
  end
end
