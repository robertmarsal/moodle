require 'rest-client'
require 'sanitize'
require 'json'

module Moodle
  module Protocol
    class Rest
      # Return must be sanitized oh html as debug on moodle site can be active 
      def request(url, params={})
        JSON.parse(Sanitize.clean(RestClient.get(url, :params => params), :remove_contents => true))
      end
    end  
  end 
end