module Moodle
  class API
    attr_reader :username, :password

    def initialize(options={})
      @username  = options[:username] || Moodle.config[:username]
      @password  = options[:password] || Moodle.config[:password]
    end
  end
end
