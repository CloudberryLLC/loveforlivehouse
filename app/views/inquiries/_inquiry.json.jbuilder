json.extract! inquiry, :id, :name, :email, :category, :content, :closed, :created_at, :updated_at
json.url inquiry_url(inquiry, format: :json)
