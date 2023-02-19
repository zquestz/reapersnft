# frozen_string_literal: true

# Manages interactions with the user model
class UsersController < ApplicationController
  # GET /users/:address/nonce
  def nonce
    params_address = Eth::Address.new user_params[:address]
    return unless params_address.valid?

    user = User.find_or_create_by!(eth_address: user_params[:address].downcase)
    render json: [eth_nonce: user.eth_nonce]
  end

  private

  def user_params
    params.permit(:address)
  end
end
