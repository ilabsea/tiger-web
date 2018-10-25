# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def download_web_guide
    send_file(
      "#{Rails.root}/public/web_guide.pdf",
      filename: "web_guide.pdf",
      type: "application/pdf"
    )
  end

  def download_mobile_guide
    send_file(
      "#{Rails.root}/public/mobile_guide.pdf",
      filename: "web_guide.pdf",
      type: "application/pdf"
    )
  end
end
