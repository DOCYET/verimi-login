require 'net/http'
require 'httparty'
require 'jwt'
require  'json'
require 'pp'

class VerimiAPI
  attr_reader :base_uri, :grant_type, :redirect_uri, :client_id, :client_secret

  def initialize
    @base_uri = URI.parse('https://verimi.com/dipp/api/')
    @grant_type = 'authorization_code'
    @redirect_uri = 'http://localhost:4200/verimi-callback'
    @client_id = 'DB'
    @client_secret = 'G|41|0an18ZIs_w'
  end

  # Requests Verimi API access token
  def self.get_access_token(query)
    @api ||= VerimiAPI.new
    @api.get_access_token(query)
  end

  def get_access_token(query)
    HTTParty.post("#{base_uri}oauth/token?grant_type=#{grant_type}&redirect_uri=#{redirect_uri}&code=#{query['code']}",
    options: {
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
    },
    basic_auth: {
     username: client_id,
     password: client_secret
    }).parsed_response
  end

  def get_baskets
    HTTParty.get("#{base_uri}query/baskets",
    options: {
      headers: {
        'Content-Type' => 'application/json'
      }
    },
    basic_auth: {
     username: client_id,
     password: client_secret
    }).parsed_response
  end

  def self.get_baskets
    @api ||= VerimiAPI.new
    @api.get_baskets
  end
end