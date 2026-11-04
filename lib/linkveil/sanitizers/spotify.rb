# frozen_string_literal: true

module Linkveil
  module Sanitizers
    class Spotify < Sanitizer
      domains 'open.spotify.com'
      remove_params 'si'
    end
  end
end
