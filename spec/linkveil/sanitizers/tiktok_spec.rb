# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Linkveil::Sanitizers::TikTok do
  describe '.clean' do
    it 'cleans TikTok tracking parameters' do
      url = 'https://www.tiktok.com/@user/video/123456?is_from_webapp=1&sender_device=pc'

      expect(Linkveil.clean(url)).to eq(
        'https://www.tiktok.com/@user/video/123456'
      )
    end

    it 'preserves unrelated TikTok parameters' do
      url = 'https://www.tiktok.com/@user/video/123456?lang=en&sender_device=pc'

      expect(Linkveil.clean(url)).to eq(
        'https://www.tiktok.com/@user/video/123456?lang=en'
      )
    end
  end
end
