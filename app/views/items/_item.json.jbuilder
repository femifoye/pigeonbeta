json.extract! item, :id, :code, :name, :price, :created_at, :updated_at
json.url item_url(item, format: :json)
