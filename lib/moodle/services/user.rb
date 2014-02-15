module Moodle
  module Service
    module User
        # Get users by field
        def core_user_get_users_by_field(field, values)
          params = {
            :field => field
          }

          # Add all the userids as array params
          counter = 0
          values.each do |id|
            params['values[' + counter.to_s + ']'] = id
            counter = counter + 1
          end

          request(params)
        end
    end
  end
end