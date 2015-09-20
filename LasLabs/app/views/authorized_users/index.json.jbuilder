json.array!(@authorized_users) do |authorized_user|
  json.extract! authorized_user, :id, :email, :company
  json.url authorized_user_url(authorized_user, format: :json)
end
