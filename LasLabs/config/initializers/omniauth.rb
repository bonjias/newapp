OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, 
    '560692254142-pfno50ig07q67b7fn9cvmlmp0tuqmog8.apps.googleusercontent.com', 
    'pLXLgKhFTsB-4pSJ5oiNbt4A', 
    {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
