# frozen_string_literal: true

# SessionsController manages user authentication
class SessionsController < ApplicationController
  # POST /session
  def create
    user = User.find_by(eth_address: params[:eth_address].downcase)
    log_in(user, params[:redirect_path]) if user.present? && verify_signature(user)
  end

  # DELETE /session
  def destroy
    log_out

    respond_to do |format|
      format.html { redirect_to root_url, status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def verify_signature(user)
    if params[:eth_signature]
      message = message(user)
      signature = params[:eth_signature]

      signature_pubkey = Eth::Signature.personal_recover message, signature
      signature_address = Eth::Util.public_key_to_address signature_pubkey

      return true if user.eth_address.downcase.eql? signature_address.to_s.downcase
    end

    false
  end

  def message(user)
    "Welcome to ReapersNFT!\n\nClick to sign in.\n\n" \
      "This request will not trigger a blockchain transaction or cost any gas fees.\n\n" \
      "Wallet address: #{user.eth_address.downcase}\n\nNonce: #{user.eth_nonce}"
  end
end
