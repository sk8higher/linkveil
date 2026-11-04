# frozen_string_literal: true

module Linkveil
  module Sanitizers
    class TikTok < Linkveil::Sanitizer
      domains 'tiktok.com'
      remove_params 'is_from_webapp', 'sender_device'
    end
  end
end
