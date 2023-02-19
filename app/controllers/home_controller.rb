# frozen_string_literal: true

# Home page controller
class HomeController < ApplicationController
  # GET /
  def index
    @screen_css_prefix = 'home-'
    @page_title = 'ReapersNFT'
    @page_description = 'Info about the ReapersNFT project.'
    @page_image_asset = ''
    @load_eth_js = !logged_in?
  end
end
