require 'pp'

module Moodle
  module Service
    module User
        # Get users by id
        def core_user_get_users_by_id(userids)
          params = {}

          # Add all the userids as array params
          counter = 0
          userids.each do |id|
            params['userids[' + counter.to_s + ']'] = id
            counter = counter + 1
          end

          request(params)
        end
    end
  end
end