module Moodle
  module Service
    module Webservice
      # Return some site info / user info / list web service functions
      def core_webservice_get_site_info
        Hashie::Mash.new request
      end
    end
  end
end