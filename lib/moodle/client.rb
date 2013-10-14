require 'moodle/protocols/rest'
require 'pp'

module Moodle
  class Client
    attr_reader :username, :password, :token, :protocol, :domain, :service

    def initialize(options={})
      @username  = options[:username] || Moodle.config[:username]
      @password  = options[:password] || Moodle.config[:password]
      @domain    = options[:domain]   || Moodle.config[:domain]
      @protocol  = options[:protocol] || Moodle.config[:protocol]
      @service   = options[:service]  || Moodle.config[:service]
      @token     = options[:token]    || Moodle.config[:token]
      
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
      response['token']
    end

    def request(url, params={})
      @client.request(url, params)
    end
  end
end


