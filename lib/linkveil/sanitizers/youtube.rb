# frozen_string_literal: true

module Linkveil
  module Sanitizers
    class YouTube < Linkveil::Sanitizer
      domains 'youtube.com', 'youtu.be'
      remove_params 'si', 'feature'
    end
  end
end
