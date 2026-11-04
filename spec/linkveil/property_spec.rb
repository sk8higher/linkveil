# frozen_string_literal: true

require 'spec_helper'
require_relative '../support/url_generator'

RSpec.describe Linkveil do
  describe 'properties' do
    it 'is idempotent' do
      seed = Random.new_seed
      rng = Random.new(seed)

      1000.times do |i|
        url = UrlGenerator.generate(rng:)

        once = described_class.clean(url)
        twice = described_class.clean(once)

        expect(twice).to eq(once), "Seed: #{seed}, iteration: #{i}, URL: #{url}"
      end
    end

    it 'preserves non-tracking parameters' do
      1000.times do
        rng = Random.new(42)
        url = UrlGenerator.generate(rng:)

        original_params = URI.decode_www_form(URI.parse(url).query.to_s)

        cleaned = described_class.clean(url)

        cleaned_params = URI.decode_www_form(URI.parse(cleaned).query.to_s)

        expected_params = original_params.reject do |key, _value|
          %w[si feature].include?(key)
        end

        expect(cleaned_params).to eq(expected_params)
      end
    end
  end
end
