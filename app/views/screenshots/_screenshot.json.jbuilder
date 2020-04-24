json.extract! screenshot, :id, :image, :created_at, :updated_at
json.url screenshot_url(screenshot, format: :json)
json.image_url url_for(screenshot.image)
