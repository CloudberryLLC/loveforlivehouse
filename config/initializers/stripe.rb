if Rails.env.development? || Rails.env.test?
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials.STRIPE_PUBLISHABLE_KEY_DEV,
    secret_key: Rails.application.credentials.STRIPE_SECRET_KEY_DEV,
    oauth_client_id: Rails.application.credentials.STRIPE_OAUTH_CLIENT_ID_DEV
  }
end

if Rails.env.production?
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials.STRIPE_PUBLISHABLE_KEY,
    secret_key: Rails.application.credentials.STRIPE_SECRET_KEY,
    oauth_client_id: Rails.application.credentials.STRIPE_OAUTH_CLIENT_ID
  }
end

#それぞれの環境に適したstripeAPIキーをセット。
Stripe.api_key = Rails.configuration.stripe[:secret_key]
