# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  describe '#save' do
    it 'downcases eth address before saving' do
      user.eth_address = 'QyZ1234'
      expect(user.save).to be(true)
      expect(user.eth_address).to eq('qyz1234')
    end

    it 'requires eth address' do
      user.eth_address = ''
      expect(user.save).to be(false)
      expect(user.errors.map(&:full_message)).to match_array(['Eth address can\'t be blank'])
    end

    it 'requires address to be unique' do
      user.save!
      user2 = build(:user, eth_address: user.eth_address)
      expect(user2.save).to be(false)
      expect(user2.errors.map(&:full_message)).to match_array(['Eth address has already been taken'])
    end

    it 'requires nonce' do
      user.eth_nonce = ''
      expect(user.save).to be(false)
      expect(user.errors.map(&:full_message)).to match_array(['Eth nonce can\'t be blank'])
    end

    it 'requires nonce to be unique' do
      user.save!
      user2 = build(:user, eth_nonce: user.eth_nonce)
      expect(user2.save).to be(false)
      expect(user2.errors.map(&:full_message)).to match_array(['Eth nonce has already been taken'])
    end
  end
end
