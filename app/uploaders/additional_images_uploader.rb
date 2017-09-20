class AdditionalImagesUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "images/#{model.class.to_s.underscore}/#{model.id}"
  end

  process resize_to_fit: [200, 200]

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
