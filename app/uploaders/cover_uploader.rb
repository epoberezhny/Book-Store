class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "images/#{model.class.to_s.underscore}/#{model.id}"
  end

  process resize_to_fit: [500, 500]

  version :thumb do
    process resize_to_fit: [300, 300]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url(*args)
    'book_default.gif'
  end
end
