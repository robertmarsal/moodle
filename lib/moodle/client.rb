require 'moodle/protocols/rest'
require 'moodle/services/user'
require 'moodle/services/course'
require 'moodle/services/cohort'
require 'moodle/services/webservice'
require 'hashie'
require 'json'

module Moodle
  class Client
    include Moodle::Service::User
    include Moodle::Service::Course
    include Moodle::Service::Cohort
    include Moodle::Service::Webservice

    attr_reader :username, :password, :domain, :protocol, :service, :format, :token

    def initialize(options={})
      @username = options[:username] || Moodle.config[:username]
      @password = options[:password] || Moodle.config[:password]
      @domain   = options[:domain]   || Moodle.config[:domain]
      @protocol = options[:protocol] || Moodle.config[:protocol]
      @service  = options[:service]  || Moodle.config[:service]
      @format   = options[:format]   || Moodle.config[:format]
      @token    = options[:token]    || Moodle.config[:token]

      # If no token is provided generate one
      if @token.nil?
        @token = self.obtain_token
      end
    end

    # Retuns a Moodle::Protocol client instance
    def client
      if @client.nil?
        # Instantiate the client protocol
        case @protocol
        when 'rest'
          @client = Moodle::Protocol::Rest.new
        else
          @client = Moodle::Protocol::Rest.new
        end
      end
      @client
    end

    # Obtains a token from the username and password
    def obtain_token
      response = client.request(@domain + '/login/token.php', {
        :username => @username, 
        :password => @password, 
        :service  => @service
      })

      parsed = JSON.parse(response)
      parsed['token']
    end

    # Make a request using the desired protocol and format
    def request(params={})
      params.merge!(
        :wstoken => @token,
        :moodlewsrestformat => @format,
        :wsfunction => caller[0][/`.*'/][1..-2]
      )
      response = client.request(@domain + '/webservice/' + @protocol + '/server.php', params)

      JSON.parse(response)
    end
  end
end