# frozen_string_literal: true

module Linkveil
  module Sanitizers
    class Instagram < Sanitizer
      domains 'instagram.com'
      remove_params 'igsh', 'igshid', 'igsi', 'stkn', 'utm_source', 'utm_medium'
    end
  end
end
