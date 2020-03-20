module Utils
  def self.full_asset_url(url)
    if url =~ URI.regexp
      url
    else
      img_url = url.present? ? url : "/no_image/no_img.png"
      URI.join(ActionController::Base.asset_host, img_url)
    end
  end
end
