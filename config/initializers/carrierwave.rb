CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['aws_id'],
      aws_secret_access_key: ENV['aws_secret'],
      region:                ENV['aws_region'],
    }
    config.fog_directory  = ENV['aws_bucket']
    # config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" }
  else
    config.storage = :file
    config.enable_processing = false
  end
end