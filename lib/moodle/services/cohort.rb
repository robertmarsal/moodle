module Moodle
  module Service
    module Cohort
      # Returns cohort details
      def core_cohort_get_cohorts(ids)
        params = {}

        counter = 0
        ids.each do |id|
          params['cohortids[' + counter.to_s + ']'] = id
          counter = counter + 1
        end

        response = request(params)

        if response.any?
          cohorts = response.map { |cohort| Hashie::Mash.new(cohort) }
        end
      end
    end
  end
end