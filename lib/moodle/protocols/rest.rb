require 'rest-client'

module Moodle
  module Protocol
    class Rest

      def request(url, params={})
        RestClient.get(url, :params => params)
      end
    end  
  end 
end