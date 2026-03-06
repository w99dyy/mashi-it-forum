# app/controllers/wallet_controller.rb
require "net/http"
require "json"

class WalletController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :check_availability, :connect, :disconnect ]
  before_action :authenticate_user!

  MASHIT_API_URL = "https://avatar-artists-guild.web.app/api/mashers/latest"

  def check_availability
    wallet_address = params[:wallet_address]&.downcase
    existing_user = User.find_by(wallet_address: wallet_address)

    if existing_user && existing_user != current_user
      render json: { available: false, message: "This wallet is already connected to another account" }, status: :unprocessable_entity
    else
      render json: { available: true, message: "Wallet available" }
    end
  end

  def connect
    wallet_address = params[:wallet_address]&.downcase
    existing_user = User.find_by(wallet_address: wallet_address)

    if existing_user && existing_user != current_user
      render json: { error: "This wallet is already connected to another account" }, status: :unprocessable_entity
      return
    end

    current_user.update!(wallet_address: wallet_address)
    render json: { success: true, address: wallet_address }
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def disconnect
    current_user.update!(wallet_address: nil, mashit_avatar_url: nil, mashit_avatar_synced_at: nil)
    render json: { success: true }
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
