require 'moodle/protocols/rest'
require 'moodle/services/user'
require 'json'

module Moodle
  class Client
    include Moodle::Service::User

    attr_reader :username, :password, :token, :protocol, :domain, :service

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
        @token = self.token
      end

      # Instantiate the client protocol
      case @protocol
      when 'rest'
        @client = Moodle::Protocol::Rest.new
      end
    end

    # Obtains a token from the username and password
    def token
      client = Moodle::Protocol::Rest.new
      response = client.request(@domain + '/login/token.php', {
        :username => @username, 
        :password => @password, 
        :service  => @service
      })
      response = JSON.parse(response)
      response['token']
    end

    # Make a request using the desired protocol and format
    def request(params={})
      params.merge!(:wstoken => @token, :moodlewsrestformat => @format)
      @client.request(@domain + '/webservice/' + @protocol + '/server.php', params)
    end
  end
end


