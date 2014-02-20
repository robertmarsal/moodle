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

          response = request(params)
          Hashie::Mash.new *response
        end

        # Search for users matching the criteria
        def core_user_get_users(criteria)
          params = {}

          counter = 0
          criteria.each do |key,value|
            params['criteria[' + counter.to_s + '][key]'] = key.to_s
            params['criteria[' + counter.to_s + '][value]'] = value
            counter = counter + 1
          end

          response = request(params)

          if response['users']
            users = response['users'].map { |user| Hashie::Mash.new(user) }
          end
        end
    end
  end
end