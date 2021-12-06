json.extract! static, :id, :title, :content, :introtext, :slug, :created_at, :updated_at
json.url static_url(static, format: :json)
