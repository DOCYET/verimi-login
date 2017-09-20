require 'jwt'
require 'pp'

class VerimiUsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  # Get request from client and requests Verimi API for Authentication Token
  def create
    raw_token = VerimiAPI.get_access_token(params)  
    id_token = JWT.decode(raw_token['id_token'], nil, false).first
    euuid = id_token['euuid']

    if User.exists?(verimi_id: euuid)
      render json: User.find_by(verimi_id: euuid ), status: 200
    else 
      @user = User.new(verimi_user_data.merge(verimi_id: euuid))
      if @user.save 
        render json: @user, status: 200
      else
        render json: ErrorSerializer.serialize(@user.errors), status: 422
      end
    end
  end

  private
   
  def verimi_user_data
    basket = VerimiAPI.get_baskets
    first_name, last_name = basket["dataScopes"][3]["data"].take(2).map { |item| item["value"] }
    email = basket["dataScopes"][2]["data"].first["value"]
    { first_name: first_name, last_name: last_name, email: email,  password: 'random',
        password_confirmation: 'random' }
  end
end
