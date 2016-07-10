json.array!(@posts) do |post|
  json.extract! post, :id, :tittle, :contenido, :extension, :user_id
  json.url post_url(post, format: :json)
end
