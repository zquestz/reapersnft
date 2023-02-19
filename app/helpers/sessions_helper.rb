# frozen_string_literal: true

# rubocop:disable Rails/HelperInstanceVariable
# rubocop:disable Rails/SkipsModelValidations

# Helper to manage user sessions
module SessionsHelper
  # Creates a new session for the user
  def log_in(user, redirect_path = nil)
    @current_user = user
    session[:user_id] = user.id
    @current_user.update_attribute(:eth_nonce, SecureRandom.uuid)
    redirect_to(redirect_path.presence || root_url)
  end

  # @return [User] logged in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # @return [Boolean] if the user is logged in.
  def logged_in?
    !current_user.nil?
  end

  # Logs out currently logged in user.
  def log_out
    Rails.cache.delete("nft_ids:#{current_user.eth_address}")

    session[:user_id] = nil
    @current_user = nil
  end

  # @param [User] user
  # @return [Boolean] if the specified user matches logged in user.
  def current_user?(user)
    user == current_user
  end

  # Redirects user to root path if not logged in.
  def authenticate_user
    redirect_to root_path unless logged_in?
  end

  # @param [String] default
  # Redirects user to forwarding_url saved in the session or
  # to the default path specified.
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Saves current URL as 'forwarding_url' in the session.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end

# rubocop:enable Rails/SkipsModelValidations
# rubocop:enable Rails/HelperInstanceVariable
