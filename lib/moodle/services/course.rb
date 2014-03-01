module Moodle
  module Service
    module Course
      # Return course details
      def core_course_get_courses(options)
        params = {}

        counter = 0
        options.each do |id|
          params['options[ids][' + counter.to_s + ']'] = id
          counter = counter + 1
        end

        response = request(params)

        if response.any?
          courses = response.map { |course| Hashie::Mash.new(course) }
        end
      end
    end
  end
end