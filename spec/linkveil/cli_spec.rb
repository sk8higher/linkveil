# frozen_string_literal: true

require 'spec_helper'
require 'open3'
require 'rbconfig'

RSpec.describe 'Linkveil CLI' do
  describe 'successful execution' do
    it 'prints cleaned URL to stdout' do
      stdout, stderr, status = Open3.capture3(
        RbConfig.ruby,
        'exe/linkveil',
        'https://youtu.be/abc?si=123'
      )

      expect(stdout).to eq("https://youtu.be/abc\n")
      expect(stderr).to be_empty
      expect(status).to be_success
    end
  end

  describe 'invalid input' do
    it 'prints usage instructions when no URL is provided' do
      stdout, stderr, status = Open3.capture3(
        RbConfig.ruby,
        'exe/linkveil'
      )

      expect(stdout).to be_empty
      expect(stderr).to eq("Usage: linkveil <url>\n")
      expect(status).not_to be_success
    end

    it 'prints usage instructions when provided URL is an empty string' do
      stdout, stderr, status = Open3.capture3(
        RbConfig.ruby,
        'exe/linkveil',
        ''
      )

      expect(stdout).to be_empty
      expect(stderr).to eq("Usage: linkveil <url>\n")
      expect(status).not_to be_success
    end
  end
end
