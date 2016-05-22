  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "1188649934501179", "caf547782bcd55d83d16358441674bcb", :scope => "email"
  end
#config.omniauth :facebook, "1188649934501179", "caf547782bcd55d83d16358441674bcb"