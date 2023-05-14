json.extract! contact, :id, :first_name, :last_name, :email, :address, :phone_number, :restaurant_name, :created_at, :updated_at
json.url contact_url(contact, format: :json)
