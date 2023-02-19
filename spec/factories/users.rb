# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    eth_address { Eth::Key.new.address }
    eth_nonce { SecureRandom.uuid }
  end
end
